# install.packages("ExPanDaR")
# Documentation: https://github.com/joachim-gassen/ExPanDaR
library(worcs)
library(ExPanDaR)
load_data()

keep <- c("language", "ktversie", "kt_personal_senior",
          "kt_team", "kt_personal_ecr", "kt_thematic", "kt_thematic_co",
          "kt_small_first", "kt_small_second", "kt_award", "kt_first_ecr",
          "kt_rolling_ecr", "kt_rolling_senior", "work_life", "grade",
          "ct", "versie", "age", "sex", "quit", "major_changes",
          "grant_no", "grant_pers_nl", "grant_pers_foreign", "grant_consortium",
          "grant_faculty", "grant_university", "grant_foundation", "grant_private",
          "nogrant_want", "nogrant_necessary", "nogrant_early", "nogrant_education",
          "nogrant_time", "nogrant_waste", "grant_success", "body_nwo",
          "body_university", "body_foreign", "body_award", "body_none",
          "rol_supervisor", "rol_head", "rol_dean", "rol_colleagues", "rol_nwo",
          "rol_ocw", "rol_mentor", "carreer_success", "need_no", "need_security",
          "need_team", "need_freedom", "need_equipment", "award_fair",
          "award_lottery", "award_time", "award_bandwagon", "who_researcher",
          "who_manager", "who_university", "who_committee", "who_government",
          "who_society", "co_private", "co_connections", "co_irrelevant",
          "time_research", "time_education", "time_phds", "time_management_low",
          "time_management_hi", "time_service", "time_admin", "time_involvement",
          "time_patients", "review_info", "review_confidence", "review_informative",
          "review_more", "review_government", "discipline", "pos5", "pos9",
          "institution")
dat <- dat[, keep]
