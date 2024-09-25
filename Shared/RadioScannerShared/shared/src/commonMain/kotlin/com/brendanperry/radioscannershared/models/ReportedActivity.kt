package com.brendanperry.radioscannershared.models

data class ReportedActivity(
    val time: String,
    val date: String,
    val nature: String,
    val address: String?
)