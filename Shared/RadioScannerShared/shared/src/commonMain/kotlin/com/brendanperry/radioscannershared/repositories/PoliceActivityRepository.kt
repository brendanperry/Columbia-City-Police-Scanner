package com.brendanperry.radioscannershared.repositories

import com.brendanperry.radioscannershared.models.ActivityLog

interface PoliceActivityRepository {
    suspend fun getActivitiesPdfDataForDate(day: Int, month: Int, year: Int): ByteArray?
    fun readPdfStringData(data: String, day: Int, month: Int, year: Int): ActivityLog
}