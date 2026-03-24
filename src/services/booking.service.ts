import { confirmBooking, createBooking, createIdempotencyKey, 
    finalizeIdempotencyKey, getIdempotencyKey } from "../repositories/booking.repository";
import { BadRequestError, NotFoundError } from "../utils/errors/app.error";
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


export async function finalizeBookingService (idempotencyKey: string) {
    const idempotencyKeyData = await getIdempotencyKey(idempotencyKey);

    if(!idempotencyKeyData){
        throw new NotFoundError("Idempotency key not found");
    }

    if(idempotencyKeyData.finalized){
        throw new BadRequestError('Idempotency key alreay finalized');
    }

    const booking = await confirmBooking(idempotencyKeyData.bookingId);
    await finalizeIdempotencyKey(idempotencyKey);

    return booking;
}

// export async function finalizeBookingService () {
    
// }
