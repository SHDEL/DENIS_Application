/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {setGlobalOptions} = require("firebase-functions");
const {onRequest} = require("firebase-functions/https");
const logger = require("firebase-functions/logger");
const { onMutationExecuted } = require("firebase-functions/v2/dataconnect");
const { createCart, addItemToCart, getCartByUserId, checkItemInCart, updateCartItem, deleteCartItem, createOrder, createOrderItem, updateStock, clearCartItems, getOrderDetails, updateOrderStatus, getInstrumentsByCategoryId } = require("./src/dataconnect-admin-generated/index.cjs");

// For cost control, you can set the maximum number of containers that can be
// running at the same time. This helps mitigate the impact of unexpected
// traffic spikes by instead downgrading performance. This limit is a
// per-function limit. You can override the limit for each function using the
// `maxInstances` option in the function's options, e.g.
// `onRequest({ maxInstances: 5 }, (req, res) => { ... })`.
// NOTE: setGlobalOptions does not apply to functions using the v1 API. V1
// functions should each use functions.runWith({ maxInstances: 10 }) instead.
// In the v1 API, each function can only serve one request per container, so
// this will be the maximum concurrent request count.
const admin = require("firebase-admin");
const cors = require("cors")({ origin: true });
admin.initializeApp();
setGlobalOptions({ maxInstances: 10 });

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

exports.helloWorld = onRequest((request, response) => {
  logger.info("Hello logs!", {structuredData: true});
  response.send("Hello from Firebase!");
});

// add to cart
exports.addToCartApi = onRequest(async (req, res) => {
  cors(req, res, async () => {
    if (req.method !== "POST") {
      res.status(405).json({ success: false, message: "Use POST method only" });
      return;
    }

    try {
      const { userId, instrumentId, qty } = req.body;

      if (!userId || !instrumentId) {
        res.status(400).json({ success: false, message: "Missing userId or instrumentId" });
        return;
      }

      let activeCartId = null;

      // ----- Step 1: เช็ค Cart เดิม -----
      const cartCheck = await getCartByUserId({ userId: userId });
      
      if (cartCheck.data && cartCheck.data.carts && cartCheck.data.carts.length > 0) {
        activeCartId = cartCheck.data.carts[0].id;
        logger.info(`เจอ Cart เดิมแล้ว (ID: ${activeCartId})`);
      } else {
        const cartResponse = await createCart({ userId: userId, quantity: 1 });
        activeCartId = cartResponse.data.cart_insert.id;
        logger.info(`สร้าง Cart ใหม่ (ID: ${activeCartId})`);
      }

      // ----- Step 2: เช็ค Item ในตะกร้า -----
      let finalCartItemId = null;
      let finalQty = qty || 1;

      const itemCheck = await checkItemInCart({ cartId: activeCartId, instrumentId: instrumentId });

      if (itemCheck.data && itemCheck.data.cartItems && itemCheck.data.cartItems.length > 0) {
        finalCartItemId = itemCheck.data.cartItems[0].id;
        finalQty = itemCheck.data.cartItems[0].qty;
        logger.info(`ใช้ Item เดิมในตะกร้า (ID: ${finalCartItemId}) จำนวน ${finalQty}`);
      } else {
        const itemResponse = await addItemToCart({
          cartId: activeCartId,
          instrumentId: instrumentId,
          quantity: finalQty
        });
        finalCartItemId = itemResponse.data.cartItem_insert.id;
        logger.info(`เพิ่งเพิ่ม Item ใส่ตะกร้า (ID: ${finalCartItemId}) จำนวน ${finalQty}`);
      }

      // ----- Step 3: สรุปผล -----
      res.status(200).json({
        success: true,
        cartItemId: finalCartItemId,
        qty: finalQty
      });

    } catch (error) {
      logger.error("เกิดข้อผิดพลาดในระบบตะกร้าสินค้า:", error);
      res.status(500).json({ 
        success: false, 
        message: "Server Error",
        error: error.message
      });
    }
   });
});

// ----------------------------------------------------
// API 2: อัปเดตจำนวนสินค้าในตะกร้า (Update Cart Item)
// ----------------------------------------------------
exports.updateCartItemApi = onRequest(async (req, res) => {
  cors(req, res, async () => {
    if (req.method !== "POST") {
      res.status(405).json({ success: false, message: "Use POST method only" });
      return;
    }

    try {
      const { cartItemId, quantity } = req.body;

      if (!cartItemId || quantity === undefined) {
        res.status(400).json({ success: false, message: "Missing cartItemId or quantity" });
        return;
      }

      await updateCartItem({ cartItemId, quantity });
      
      logger.info(`Updated cart item (ID: ${cartItemId}) to qty: ${quantity}`);
      res.status(200).json({ success: true, message: "Cart item updated" });

    } catch (error) {
      logger.error("Error updating cart item:", error);
      res.status(500).json({ success: false, message: "Server Error", error: error.message });
    }
  });
});

// ----------------------------------------------------
// API 3: ลบสินค้าออกจากตะกร้า (Delete Cart Item)
// ----------------------------------------------------
exports.deleteCartItemApi = onRequest(async (req, res) => {
  cors(req, res, async () => {
    if (req.method !== "POST") {
      res.status(405).json({ success: false, message: "Use POST method only" });
      return;
    }

    try {
      const { cartItemId } = req.body;

      if (!cartItemId) {
        res.status(400).json({ success: false, message: "Missing cartItemId" });
        return;
      }

      await deleteCartItem({ cartItemId });
      
      logger.info(`Deleted cart item (ID: ${cartItemId})`);
      res.status(200).json({ success: true, message: "Cart item deleted" });

    } catch (error) {
      logger.error("Error deleting cart item:", error);
      res.status(500).json({ success: false, message: "Server Error", error: error.message });
    }
  });
});

// ----------------------------------------------------
// API 4: สั่งซื้อสินค้า (Checkout)
// ----------------------------------------------------
exports.checkoutApi = onRequest(async (req, res) => {
  cors(req, res, async () => {
    if (req.method !== "POST") {
      res.status(405).json({ success: false, message: "Use POST method only" });
      return;
    }

    try {
      const { userId, cartId, totalItemsQty, items } = req.body;

      if (!userId || !cartId || !items || !Array.isArray(items)) {
        res.status(400).json({ success: false, message: "Missing required checkout data" });
        return;
      }

      // 1. สร้าง Order
      const orderResult = await createOrder({
        userId,
        totalQty: totalItemsQty,
        status: "Pending"
      });
      
      const newOrderId = orderResult.data.order_insert.id;
      logger.info(`Created Order (ID: ${newOrderId})`);

      // 2. นำรายการในตะกร้ามาบันทึกลง OrderItem + อัปเดต Stock
      for (const item of items) {
        await createOrderItem({
          orderId: newOrderId,
          instrumentId: item.instrumentId,
          qty: item.qty
        });

        if (item.stockId) {
          const newInStockQty = item.inStockQty - item.qty;
          const newInUseQty = item.inUseQty + item.qty;
          
          await updateStock({
            id: item.stockId,
            inStockQty: newInStockQty,
            inUseQty: newInUseQty
          });
        }
      }

      // 3. เคลียร์ตะกร้า
      await clearCartItems({ cartId });
      logger.info(`Cleared Cart (ID: ${cartId})`);

      res.status(200).json({
        success: true,
        message: "Checkout successful",
        orderId: newOrderId
      });

    } catch (error) {
      logger.error("Error during checkout:", error);
      res.status(500).json({ success: false, message: "Server Error", error: error.message });
    }
  });
});

exports.updateOrderStatusApi = onRequest(async (req, res) => {
  cors(req, res, async () => {
    if (req.method !== "POST") {
      res.status(405).json({ success: false, message: "Use POST method only" });
      return;
    }

    try {
      const { orderId, newStatus} = req.body;

      if (!orderId || !newStatus) {
        res.status(400).json({ success: false, message: "Missing orderId or newStatus" });
        return;
      }

      await updateOrderStatus({ orderId, newStatus });
      
      if (newStatus === 'Returned' || newStatus === 'Cancelled') {
        const orderDetails = await getOrderDetails({ orderId }); // ดึงข้อมูลออเดอร์ล่าสุดหลังจากอัปเดตสถานะ เพื่อให้แน่ใจว่าเรามีข้อมูลล่าสุดสำหรับการอัปเดตสต็อก
        const orderItems = orderDetails.data?.order?.orderItems_on_order || [];
        // 2. วนลูปเพื่อ Update Stock ถ้ามีการส่งรายการที่มีรายละเอียดของสต็อกเข้ามา
        // const items = orderDetails.data.orderByPk.orderItems.map(item => ({
        //   stockId: item.instrument.stocks_on_instrument[0]?.id,
        //   inStockQty: item.instrument.stocks_on_instrument[0]?.inStockQty,
        //   inUseQty: item.instrument.stocks_on_instrument[0]?.inUseQty,
        //   qty: item.qty
        // }));
        for (const item of orderItems) {
          // ดึง stock ก้อนแรกที่ผูกกับเครื่องมือนั้น
          const stockInfo = item.instrument?.stocks_on_instrument?.[0];
          
          if (stockInfo) {
            const qtyReturned = item.qty;
            
            // คำนวณสต็อกใหม่
            // ของกลับเข้าคลัง = ของเดิม + ที่ยืมไป
            const newInStockQty = stockInfo.inStockQty + qtyReturned;
            
            // ของถูกใช้งานลดลง = ของถูกใช้งานเดิม - ที่ยืมไป (ใช้ Math.max กันติดลบเผื่อไว้)
            const newInUseQty = Math.max(0, stockInfo.inUseQty - qtyReturned);
            
            await updateStock({
              id: stockInfo.id,
              inStockQty: newInStockQty,
              inUseQty: newInUseQty
            });
            
            logger.info(`Returned Stock (Stock ID: ${stockInfo.id}) -> Added ${qtyReturned} to InStock. New InStock: ${newInStockQty}, New InUse: ${newInUseQty}`);
          }
        }
      }
      
      logger.info(`Updated Order (ID: ${orderId}) status to: ${newStatus}`);
      res.status(200).json({ success: true, message: "Order status updated" });

    } catch (error) {
      logger.error("Error updating order status:", error);
      res.status(500).json({ success: false, message: "Server Error", error: error.message });
    }
  });
});

exports.addSetToCartApi = onRequest(async (req, res) => {
  cors(req, res, async () => {
    if (req.method !== "POST") {
      res.status(405).json({ success: false, message: "Use POST method only" });
      return;
    }

    try {
      const { userId, categoryId } = req.body;

      if (!userId || !categoryId) {
        res.status(400).json({ success: false, message: "Missing userId or categoryId" });
        return;
      }

      // 1. ดึง Cart ของ User (หรือสร้างใหม่ถ้าไม่มี)
      let activeCartId = null;
      const cartCheck = await getCartByUserId({ userId: userId });
      
      if (cartCheck.data && cartCheck.data.carts && cartCheck.data.carts.length > 0) {
        activeCartId = cartCheck.data.carts[0].id;
      } else {
        const cartResponse = await createCart({ userId: userId, quantity: 1 });
        activeCartId = cartResponse.data.cart_insert.id;
      }

       // 2. เรียกใช้ Query ฝั่ง DataConnect
      const instrumentsResponse = await getInstrumentsByCategoryId({ categoryId: categoryId });
      const instruments = instrumentsResponse.data.instruments || [];

      if (!instruments || instruments.length === 0) {
        res.status(200).json({ success: true, message: "No instruments found in this category", addedCount: 0 });
        return;
      }

      // 3. วนลูปเพิ่มสินค้าเข้าตะกร้า
      let addedCount = 0;
      for (const inst of instruments) {
        // เช็คก่อนว่ามีในตะกร้าแล้วหรือยัง
        const itemCheck = await checkItemInCart({ cartId: activeCartId, instrumentId: inst.id });
        if (!itemCheck.data || !itemCheck.data.cartItems || itemCheck.data.cartItems.length === 0) {
           await addItemToCart({
             cartId: activeCartId,
             instrumentId: inst.id,
             quantity: 1
           });
           addedCount++;
        }
      }

      logger.info(`Added ${addedCount} items from category ${categoryId} to user ${userId}'s cart.`);
      res.status(200).json({ success: true, message: "Add set to cart successful", addedCount: addedCount });

    } catch (error) {
      logger.error("Error adding set to cart:", error);
      res.status(500).json({ success: false, message: "Server Error", error: error.message });
    }
  });
});