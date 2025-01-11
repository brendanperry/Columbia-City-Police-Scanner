package com.brendanperry.radioscannershared

import com.brendanperry.radioscannershared.repositories.CCPoliceActivityRepository
import kotlin.test.Test
import kotlin.test.assertTrue

class CCPoliceActivityRepositoryTest {
    @Test
    fun testBuildingLogFromPdfString() {
        val repository = CCPoliceActivityRepository()

        val log = repository.readPdfStringData(
            "Reported Nature Incident address\n00:12:35 09/11/24 Foot Ptrl Nbrhd\n00:23:27 09/11/24 Traffic Stop W US 30 EB & N TEST LAKE BLVD\n00:31:20 09/11/24 Susp Vehicle 2XX N TESTING RD\n01:55:19 09/11/24 Traffic Stop W US 30 EB & N TESTING DR\n02:19:20 09/11/24 Traffic Stop E US 30 EB & S 250 W\n02:32:45 09/11/24 Traffic Stop W US 30 EB & W TESTING DR\n02:41:15 09/11/24 Foot Ptrl Busn\n04:53:11 09/11/24 Traffic Hazard S TESTING ST & W TESTER AVE\n05:49:38 09/11/24 Ast Fire 2XX E TEST ST\n07:26:44 09/11/24 SRO Activity 12XX W SR 33\n07:40:38 09/11/24 SRO Activity 11XX N SR 78\n07:50:02 09/11/24 Foot Ptrl Nbrhd\n08:08:34 09/11/24 SRO Activity 10XX N SR 89\n08:32:54 09/11/24 Susp Vehicle 1XX W TEST ST\n09:24:15 09/11/24 SRO Activity 4XX E TESTER ST\n09:38:54 09/11/24 Foot Ptrl Busn\n09:51:56 09/11/24 Ast EMS 12XX N SR 23\n09:54:07 09/11/24 SRO Activity 19XX W SR 34\n10:18:58 09/11/24 SRO Activity 10XX N SR 56\n10:25:48 09/11/24 Foot Ptrl Busn\n10:28:34 09/11/24 SRO Activity 78XX N SR 119\n10:28:46 09/11/24 SRO Activity 13XX S SR 11\n10:48:54 09/11/24 Traffic Stop 9XX W TESTER ST\n10:53:49 09/11/24 Traffic Stop W US 30 EB & N TESTER DR\n11:10:39 09/11/24 Foot Ptrl Busn\n11:18:19 09/11/24 Traffic Stop E TEST ST & S TESTING ST\n11:29:08 09/11/24 Traffic Stop E US 30 EB & E SR 215\n11:31:56 09/11/24 SRO Activity 2XX S 555 E\n11:33:38 09/11/24 Foot Ptrl Busn\n12:14:24 09/11/24 Traffic Stop S SR 55 & S 51 N\n12:31:01 09/11/24 Traffic Stop E TESTER ST & N TEST AVE\n12:32:50 09/11/24 SRO Activity 11XX N SR 12\n13:02:04 09/11/24 Traffic Stop S TEST ST & E TESTING ST\n14:11:49 09/11/24 SRO Activity 1XX S SR 99\n14:37:06 09/11/24 Theft Vehicle 1XX E TEST RD\n14:37:29 09/11/24 SRO Activity 6XX S SR 45\n15:25:51 09/11/24 Juvenile 1XX N TEST ST\n15:45:20 09/11/24 Welfare Check 5XX S TEST ST\n18:16:07 09/11/24 Vehicle Lockout 7XX W TESTING ST\n18:39:30 09/11/24 Traffic Stop W US 30 EB & N TESTING DR\n18:40:10 09/11/24 Traffic Stop W US 30 EB & W TEST RD\n19:02:08 09/11/24 Traffic Stop W US 30 EB & N TEST DR\n19:18:26 09/11/24 Traffic Stop W US 30 EB & W TESTER RD\n19:39:14 09/11/24 Traffic Stop W US 30 EB & W TESTER RD\n19:53:20 09/11/24 Crim Trespass 9XX W TEST BLVD\n20:10:16 09/11/24 Disturb Domest 0XX N TEST DR\n20:48:14 09/11/24 Unwanted Party 5XX S TEST DR\n21:50:15 09/11/24 Traffic Stop E US 30 EB & S 555 E\n22:24:59 09/11/24 Traffic Stop TEST ST & E TEST ST\n22:34:51 09/11/24 Traffic Stop S TEST ST & W TEST ST\n23:04:10 09/11/24 Traffic Stop E US 30 EB & E SR 5\n23:40:11 09/11/24 Traffic Stop W US 30 EB & W TESTER RD\n11/7/2024 7:08:24 AM Page 1 of 1",
            1,
            1,
            24
        )

        assertTrue {
            log?.reportedActivity?.count() == 52
        }
    }

    @Test
    fun test2BuildingLogFromPdfString() {
        val repository = CCPoliceActivityRepository()

        val log = repository.readPdfStringData(
            "Reported Nature Incident address\n00:00:00 12/18/24 Vac Home Check\n00:28:34 12/18/24 Traffic Stop E US 30 EB & E SR 205\n00:47:59 12/18/24 Traffic Stop E US 30 EB & E SR 205\n00:58:54 12/18/24 Traffic Stop E US 30 EB & E 100 S\n02:14:17 12/18/24 Traffic Stop W US 30 EB & N WOLF RD\n02:22:32 12/18/24 Traffic Stop W US 30 EB & N 300 W\n03:33:57 12/18/24 Ast Anoth Agcy W US 30 EB & N WILSON LAKE RD\n06:12:20 12/18/24 Veh Crash LvScn 10XX E US 30\n07:20:01 12/18/24 SRO Activity 52XX N SR 109\n07:25:56 12/18/24 SRO Activity 16XX S SR 9\n07:36:32 12/18/24 SRO Activity 16XX S SR 9\n08:06:14 12/18/24 SRO Activity 16XX S SR 9\n08:32:57 12/18/24 SRO Activity 7XX E JACKSON ST\n09:08:39 12/18/24 SRO Activity 22XX S 500 E\n10:25:32 12/18/24 SRO Activity 16XX S SR 9\n10:28:47 12/18/24 Citizen Assist 5XX E BUSINESS 30\n10:32:57 12/18/24 Burglary 6XX W BUSINESS 30\n10:38:58 12/18/24 SRO Activity 16XX S SR 9\n11:07:31 12/18/24 SRO Activity 3XX N WASHINGTON ST\n11:23:14 12/18/24 SRO Activity 16XX S SR 9\n11:40:24 12/18/24 SRO Activity 16XX S SR 9\n11:48:37 12/18/24 Citizen Assist 5XX N PINECREST DR\n12:32:08 12/18/24 SRO Activity 16XX S SR 9\n13:33:28 12/18/24 Insp - VIN 10XX W GREEN MEADOW RUN\n13:34:28 12/18/24 SRO Activity 16XX S SR 9\n14:00:55 12/18/24 SRO Activity 17XX S SR 9\n14:02:39 12/18/24 SRO Activity 16XX S SR 9\n14:09:24 12/18/24 Traffic Stop E VAN BUREN ST & N MADISON ST\n14:15:23 12/18/24 Traffic Stop E VAN BUREN ST & N MARSHALL AVE\n14:26:22 12/18/24 Animal Danger 2XX S ELM ST\n14:28:25 12/18/24 Traffic Stop E VAN BUREN ST & N ROLLING HILLS AVE\n14:30:21 12/18/24 Citizen Assist 1XX S CHAUNCEY ST\n14:38:31 12/18/24 SRO Activity 16XX S SR 9\n14:50:38 12/18/24 Ast Traffic Stp E US 30 EB & E SR 205\n15:15:36 12/18/24 Traffic Stop W NORTH ST & N PINECREST DR\n15:23:13 12/18/24 Traffic Stop 2XX W FRONTAGE RD\n15:27:19 12/18/24 Traffic Stop N MAIN ST & E COUNTRYSIDE DR\n15:33:21 12/18/24 Foot Ptrl Busn\n15:50:01 12/18/24 Traffic Stop N MAIN ST & E JEFFERSON ST\n15:59:34 12/18/24 Assault 4XX N LINE ST\n16:07:54 12/18/24 Assault 4XX N PARK TERRACE BLVD\n17:29:04 12/18/24 Suspicious 4XX W PLAZA DR\n17:32:08 12/18/24 Vehicle Lockout 5XX N MAIN ST\n17:42:04 12/18/24 Veh Crash LvScn 4XX W PLAZA DR\n19:02:59 12/18/24 Traffic Stop W FRONTAGE RD & N LINE ST\n19:06:46 12/18/24 Traffic Stop 1XX N HOOSIER DR\n19:31:12 12/18/24 Traffic Stop E US 30 EB & E 100 S\n19:39:16 12/18/24 Traffic Stop W US 30 EB & W LINCOLNWAY RD\n19:53:32 12/18/24 Traffic Stop W US 30 EB & N ARMSTRONG DR\n19:58:22 12/18/24 Traffic Stop W LINCOLNWAY RD & W DEPOY DR\n20:05:30 12/18/24 Citizen Assist XX W DIPLOMAT DR\n20:34:44 12/18/24 Traffic Stop 3XX W PLAZA DR\n20:36:14 12/18/24 Traffic Stop N MAIN ST & E NORTH ST\n20:41:40 12/18/24 Traffic Stop 4XX W PLAZA DR\n20:48:46 12/18/24 Driving Comp E US 30 EB & N MAIN ST\n21:03:11 12/18/24 Traffic Stop N LINE ST & W FRONTAGE RD\n21:55:11 12/18/24 Welfare Check 3XX N CHAUNCEY ST\n22:35:49 12/18/24 Traffic Stop 22:49:12 12/18/24 Traffic Stop 22:59:06 12/18/24 Foot Ptrl Busn\n23:01:36 12/18/24 Traffic Stop 23:38:57 12/18/24 Traffic Stop 23:56:53 12/18/24 Ast Traffic Stp E US 30 EB & N MAIN ST\nE US 30 EB & E SR 205\nW US 30 EB & N WOLF RD\nE US 30 EB & S 300 E\nE US 30 EB & E SR 205",
            1,
            1,
            24
        )

        assertTrue {
            log?.reportedActivity?.count() == 52
        }
    }
}