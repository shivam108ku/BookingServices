import { z } from "zod";

export const createBookingSchema = z.object({
    userId: z.number({ message: "User id must me present"}),
    hotelId: z.number({message: "Hotel Id must be present"}),
    totalGuests: z.number({message: "Total guests must be present"}).min(1, {message: "Total guest must be atleast 1"}),
    bookingAmount: z.number({message: "Booking amount must be present"}).min(1, {message: "Booking amount must be 1"})
})