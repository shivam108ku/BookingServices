import { PrismaClient } from "../generated/prisma/client";

// Use a global variable to store the PrismaClient instance in development.
// This avoids creating a new instance on every module reload.
const globalForPrisma = global as unknown as { prisma?: PrismaClient };

export const prisma =
  globalForPrisma.prisma ??
  new PrismaClient({} as any);

if (process.env.NODE_ENV !== "production") globalForPrisma.prisma = prisma;

// Handle graceful shutdown
process.on("SIGINT", async () => {
  await prisma.$disconnect();
  process.exit(0);
});

process.on("SIGTERM", async () => {
  await prisma.$disconnect();
  process.exit(0);
});

export default prisma;
