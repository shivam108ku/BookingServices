import { createBooking, createIdempotencyKey } from "../repositories/booking.repository";
import { generateIdempotencyKey } from "../utils/generateIdempotencyKey";


export async function createBookingService (
    userId: number,
    hotelId: number,
    totalGuests: number,
    bookingAmount: number,
    checkInDate: Date,
) {
   //  Implement the login here
   const booking = await createBooking({
    userId,
    hotelId,
    totalGuests: totalGuests,
    bookingAmount: bookingAmount,
   });

   const idempotencyKey = generateIdempotencyKey();
   await createIdempotencyKey(idempotencyKey, booking.id)

   return {
    bookingId: booking.id,
    idempotencyKey: idempotencyKey,
   }

}


export async function finalizeBookingService () {
    
}

// export async function finalizeBookingService () {
    
// }