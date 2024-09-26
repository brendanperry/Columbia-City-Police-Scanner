package com.brendanperry.radioscannershared.repositories

import com.brendanperry.radioscannershared.models.ActivityLog
import com.brendanperry.radioscannershared.models.City
import com.brendanperry.radioscannershared.models.ReportedActivity
import com.brendanperry.radioscannershared.sources.HttpClient
import io.ktor.client.call.body
import io.ktor.client.request.get

class CCPoliceActivityRepository : PoliceActivityRepository {
    private val baseUrl = "https://columbiacitypolice.us"

    override suspend fun getActivitiesPdfDataForDate(day: Int, month: Int, year: Int): ByteArray? {
        val client = HttpClient.client

        val response = client.get("$baseUrl/documents/DAILY%20STATS/$month.$day.$year.pdf")

        if (response.status.value in 200..299) {
            val byteArrayBody: ByteArray = response.body()

            return byteArrayBody
        }

        return null
    }

    override fun readPdfStringData(data: String, day: Int, month: Int, year: Int): ActivityLog {
        val reportedActivities = arrayListOf<ReportedActivity>()

        val lines = data.split("\n")

        for ((index, line) in lines.withIndex()) {
            if (index == 0) continue

            val spaceSplit = line.split(" ", limit = 3)
            val time = spaceSplit[0]
            val date = spaceSplit[1]

            val natureAndAddress = spaceSplit[2]

            val natureAndLocationSplit =
                natureAndAddress.split(Regex("( E | S | W | N | \\d)"), limit = 2)
            val nature = natureAndLocationSplit[0]
            var location: String? = null
            if (natureAndLocationSplit.count() > 1) {
                location = natureAndLocationSplit[1]
                val pieces = location.split(" ")

                // TODO: needs refactor
                var finalAddress = ""
                for (piece in pieces) {
                    if (!piece.contains("XX")) {
                        if (finalAddress.isNotEmpty()) {
                            finalAddress += " "
                        }
                        finalAddress += piece
                    }
                }

                location = finalAddress
            }

            val reportedActivity = ReportedActivity(time, date, nature, location)
            reportedActivities.add(reportedActivity)
        }

        return ActivityLog(day, month, year, City.COLUMBIA_CITY, reportedActivities)
    }
}