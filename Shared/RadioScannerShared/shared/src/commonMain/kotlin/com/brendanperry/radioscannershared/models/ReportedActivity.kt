package com.brendanperry.radioscannershared.models

import kotlinx.datetime.LocalDateTime

data class ReportedActivity(
    val time: String,
    val date: String,
    val nature: String,
    val address: String?,
    val dateTime: LocalDateTime
)