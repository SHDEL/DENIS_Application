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
const express = require("express");

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
setGlobalOptions({ maxInstances: 10 });

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   if (request.path === "/helloCountry") {
//     response.send("Hello from Country!");
//   } 
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

// exports.order = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   if (request.path === "/create") {

//   }
  
//   if (request.path === "/update") {

//   }
//   response.send("Hello from Firebase!");
// });

// exports.cart = onRequest((request, response) => {
//   if (request.path === "/add") {

//   }
  
//   if (request.path === "/remove") {

//   }

// });
const app = express();

app.use(express.json()); // ให้รองรับการรับค่า Body เป็น JSON

// ----------------------------------------------------
// Order API
// ----------------------------------------------------
app.post("/hello", async (req, res) => {
  // สำหรับการอัปเดตสเตตัส Order (เช่น จาก Pending -> Shipping)
  res.status(200).json({ success: true, message: "Hello from Firebase!" });
});
app.post("/order/create", async (req, res) => {
  try {
    const userId = req.body.userId;
    // สิ่งที่ควรทำ:
    // 1. Validate ว่า User มีตัวตนจริงไหม 
    // 2. เช็คสต๊อกว่าสินค้าพอให้เบิกไหม
    // 3. ใช้ Data Connect Node.js SDK หรือ Firebase Admin ส่งคำสั่งเคลียร์ตะกร้าและสร้างออเดอร์
    
    logger.info(`Received create order request for user ${userId}`);
    res.status(200).json({ success: true, message: "Order created successfully" });
  } catch (error) {
    logger.error("Error creating order", error);
    res.status(500).json({ success: false, error: error.message });
  }
});

app.post("/order/update", (req, res) => {
  // สำหรับการอัปเดตสเตตัส Order (เช่น จาก Pending -> Shipping)
  res.send("Update order logic here");
});


// ----------------------------------------------------
// Export Firebase Cloud Functions
// ----------------------------------------------------
// เราสามารถมัดรวม API ทั้งหมดไว้ใน path เดียว เช่น https://.../api/order/create
exports.api = onRequest(app);