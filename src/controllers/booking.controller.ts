import { Request, Response } from "express";
import { createBookingService } from "../services/booking.service";

export const creteBookingHandler = async(req: Request, res: Response) => {

    const booking = await createBookingService (req.body);

    res.status(201).json({
        bookingId: booking.bookingId,
        idempotencyKey: booking.idempotencyKey,
    })
}