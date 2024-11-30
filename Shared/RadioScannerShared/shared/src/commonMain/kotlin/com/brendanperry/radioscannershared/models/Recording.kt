package com.brendanperry.radioscannershared.models

import kotlinx.datetime.LocalDateTime

data class RecordingTime(
    val startHour: Int,
    val startMinute: Int,
    val endHour: Int,
    val endMinute: Int
)

data class Recording(
    val title: String,
    val id: String,
    val startTime: LocalDateTime,
    val endTime: LocalDateTime
) {
    companion object {
        // November 20 2024 03:00 to 03:14 AM
        fun getTime(title: String): RecordingTime {
            val split = title.split(" ")

            val startTime = split[3]
            val endTime = split[5]
            val amPm = split[6]

            val startSplit = startTime.split(":")
            var startHour = startSplit[0]
            val startMinute = startSplit[1]

            val endSplit = endTime.split(":")
            var endHour = endSplit[0]
            val endMinute = endSplit[1]

            if (amPm == "PM" && startHour != "12") {
                startHour += 12
                endHour += 12
            }

            return RecordingTime(
                startHour.toInt(),
                startMinute.toInt(),
                endHour.toInt(),
                endMinute.toInt()
            )
        }
    }
}
