import express from 'express';
import {  validateRequestBody } from '../../validators/index.js';
import { creteBookingHandler } from '../../controllers/booking.controller.js';
import { createBookingSchema } from '../../validators/booking.validator.js';
 

const bookingRouter = express.Router();

bookingRouter.post('/', validateRequestBody(createBookingSchema), creteBookingHandler);
 

export default bookingRouter;