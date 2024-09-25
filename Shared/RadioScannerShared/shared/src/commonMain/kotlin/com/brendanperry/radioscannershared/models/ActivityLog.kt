package com.brendanperry.radioscannershared.models

data class ActivityLog(
    val day: Int,
    val month: Int,
    val year: Int,
    val location: City,
    val reportedActivity: List<ReportedActivity>
)