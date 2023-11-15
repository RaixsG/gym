import dayjs from "dayjs";
import { PrismaClient } from "@prisma/client";
import { Router } from "express";

const router = Router();
const prisma = new PrismaClient();

router.get('/instructores', async (_, res) => {
    const allInstructores = await prisma.instructores.findMany();
    res.json(allInstructores);
});



export default router;