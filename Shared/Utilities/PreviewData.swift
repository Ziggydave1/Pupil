//
//  PreviewData.swift
//  Pupil
//
//  Created by Evan Kaneshige on 4/5/23.
//

import Foundation
import SwiftVue

class PreviewData {
    
    static let instance = PreviewData()
    
    let credentials = Credentials(username: "", password: "", districtURL: "")
    // Gradebook
    let multiMarkGradebook = Gradebook(
        reportingPeriods: [
            ReportPeriod(index: "0", name: "1st 6 Weeks", startDate: "8/10/2022", endDate: "9/16/2022"),
            ReportPeriod(index: "1", name: "2nd 6 Weeks", startDate: "9/19/2022", endDate: "11/1/2022"),
            ReportPeriod(index: "2", name: "3rd 6 Weeks", startDate: "11/2/2022", endDate: "12/20/2022"),
            ReportPeriod(index: "3", name: "4th 6 Weeks", startDate: "1/5/2023", endDate: "2/17/2023"),
            ReportPeriod(index: "4", name: "5th 6 Weeks", startDate: "2/21/2023", endDate: "4/14/2023"),
            ReportPeriod(index: "5", name: "6th 6 Weeks", startDate: "4/17/2023", endDate: "5/25/2023")
        ],
        reportingPeriod: ReportingPeriod(
            name: "3rd 6 Weeks",
            startDate: "11/2/2022",
            endDate: "12/20/2022"
        ),
        courses: [
            Course(
                period: "2",
                title: "AP Calculus BC",
                room: "492",
                staff: "John Leibniz",
                staffEmail: "leibniz@school.edu",
                marks: [
                    Mark(
                        name: "3rd 6 Wk",
                        scoreString: "A+",
                        scoreRaw: "100",
                        gradeCalculationSumary: [
                            GradeCalculationPart(
                                name: "Homework",
                                weight: "20%",
                                points: "70.00",
                                pointsPossible: "70.00",
                                calculatedMark: "A+",
                                weightedPct: "20.00%"
                            ),
                            GradeCalculationPart(
                                name: "TOTAL",
                                weight: "100%",
                                points: "70.00",
                                pointsPossible: "70.00",
                                calculatedMark: "A+",
                                weightedPct: "100.00%"
                            ),
                            GradeCalculationPart(
                                name: "Test",
                                weight: "50%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            ),
                            GradeCalculationPart(
                                name: "Quiz",
                                weight: "30%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            )
                        ],
                        assignments: [
                            Assignment(
                                name: "Week of Nov. 14th",
                                type: "Homework",
                                date: "11/17/2022",
                                due: "11/17/2022",
                                score: "20 out of 20.0000",
                                scoreType: "Raw Score",
                                points: "15.00 / 20.0000",
                                notes: "",
                                description: "Week of Nov. 14th",
                                resources: []
                            ),
                            Assignment(
                                name: "Week of Nov. 7th",
                                type: "Homework",
                                date: "11/14/2022",
                                due: "11/14/2022",
                                score: "20 out of 20.0000",
                                scoreType: "Raw Score",
                                points: "20.00 / 20.0000",
                                notes: "",
                                description: "Week of Nov. 7th",
                                resources: []
                            ),
                            Assignment(
                                name: "Week of Oct. 31st",
                                type: "Homework",
                                date: "11/7/2022",
                                due: "11/7/2022",
                                score: "30 out of 30.0000",
                                scoreType: "Raw Score",
                                points: "30.00 / 30.0000",
                                notes: "",
                                description: "Week of Oct. 31st",
                                resources: []
                            ),
                            Assignment(
                                name: "Quiz 1",
                                type: "Quiz",
                                date: "11/7/2022",
                                due: "11/7/2022",
                                score: "30 out of 30.0000",
                                scoreType: "Raw Score",
                                points: "30.00 / 30.0000",
                                notes: "",
                                description: "Week of Oct. 31st",
                                resources: []
                            )
                        ]
                    ),
                    Mark(
                        name: "S1 Exam",
                        scoreString: "N/A",
                        scoreRaw: "0",
                        gradeCalculationSumary: [
                            GradeCalculationPart(
                                name: "TOTAL",
                                weight: "100%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "N/A",
                                weightedPct: "100.00%"
                            ),
                            GradeCalculationPart(
                                name: "Homework",
                                weight: "20%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            ),
                            GradeCalculationPart(
                                name: "Test",
                                weight: "50%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            ),
                            GradeCalculationPart(
                                name: "Quiz",
                                weight: "30%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            )
                        ],
                        assignments: []
                    ),
                    Mark(
                        name: "S1 Grade",
                        scoreString: "A+",
                        scoreRaw: "98",
                        gradeCalculationSumary: [
                            GradeCalculationPart(
                                name: "TOTAL",
                                weight: "100%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "A+",
                                weightedPct: "100.00%"
                            ),
                            GradeCalculationPart(
                                name: "Homework",
                                weight: "20%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            ),
                            GradeCalculationPart(
                                name: "Test",
                                weight: "50%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            ),
                            GradeCalculationPart(
                                name: "Quiz",
                                weight: "30%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            )
                        ],
                        
                        assignments: []
                    )
                ]
            ),
            Course(
                period: "3",
                title: "AP English Literature",
                room: "154",
                staff: "Virginia Woolf",
                staffEmail: "woolf.v@school.edu",
                marks: [
                    Mark(
                        name: "3rd 6 Wk",
                        scoreString: "B",
                        scoreRaw: "85.1",
                        gradeCalculationSumary: [
                            GradeCalculationPart(
                                name: "Assignments/Assessments",
                                weight: "60%",
                                points: "15.35",
                                pointsPossible: "19.00",
                                calculatedMark: "B-",
                                weightedPct: "48.47%"
                            ),
                            GradeCalculationPart(
                                name: "Participation and Engagement",
                                weight: "15%",
                                points: "5.13",
                                pointsPossible: "5.00",
                                calculatedMark: "A+",
                                weightedPct: "15.38%"
                            ),
                            GradeCalculationPart(
                                name: "TOTAL",
                                weight: "100%",
                                points: "20.48",
                                pointsPossible: "24.00",
                                calculatedMark: "B",
                                weightedPct: "85.10%"
                            ),
                            GradeCalculationPart(
                                name: "AP Practice",
                                weight: "10%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            ),
                            GradeCalculationPart(
                                name: "Final Exam",
                                weight: "15%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            )
                        ],
                        assignments: [
                            Assignment(
                                name: "Literary Costume Halloween",
                                type: "Participation and Engagement",
                                date: "10/31/2022",
                                due: "10/31/2022",
                                score: "1",
                                scoreType: "Grading Scale 0-5",
                                points: "0.33 / 0.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "1984 Part III Discussion",
                                type: "Participation and Engagement",
                                date: "10/28/2022",
                                due: "10/28/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "0.95 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "1984 Part IIII QCCQ",
                                type: "Assignments/Assessments",
                                date: "10/28/2022",
                                due: "10/28/2022",
                                score: "Not Graded",
                                scoreType: "Grading Scale 0-5",
                                points: "2.0000 Points Possible",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "1984 Part II Ch. 7-10 Discussion",
                                type: "Participation and Engagement",
                                date: "10/21/2022",
                                due: "10/21/2022",
                                score: "5",
                                scoreType: "Grading Scale 0-5",
                                points: "1.00 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "\"The Landlady\" Q1",
                                type: "Assignments/Assessments",
                                date: "10/18/2022",
                                due: "10/18/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "2.85 / 3.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "1984 Discussion Part II 1-6",
                                type: "Participation and Engagement",
                                date: "10/14/2022",
                                due: "10/14/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "0.95 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "1984 Pt II 1-6 QCCQ",
                                type: "Assignments/Assessments",
                                date: "10/14/2022",
                                due: "10/14/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "1.90 / 2.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "1984 Discussion Part I",
                                type: "Participation and Engagement",
                                date: "10/5/2022",
                                due: "10/5/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "0.95 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "1984 Pt 1 QCCQ",
                                type: "Assignments/Assessments",
                                date: "10/5/2022",
                                due: "10/5/2022",
                                score: "5",
                                scoreType: "Grading Scale 0-5",
                                points: "2.00 / 2.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Vonnegut QCQ",
                                type: "Assignments/Assessments",
                                date: "10/3/2022",
                                due: "10/3/2022",
                                score: "0.5",
                                scoreType: "Grading Scale 0-5",
                                points: "0.50 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Bradbury/Vonnegut TW",
                                type: "Assignments/Assessments",
                                date: "9/30/2022",
                                due: "9/30/2022",
                                score: "0",
                                scoreType: "Grading Scale 0-5",
                                points: "0.00 / 2.0000",
                                notes: "Missing ",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Bradbury Story Analysis",
                                type: "Assignments/Assessments",
                                date: "9/23/2022",
                                due: "9/23/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "1.90 / 2.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Analysis Paragraph",
                                type: "Assignments/Assessments",
                                date: "9/16/2022",
                                due: "9/16/2022",
                                score: "2",
                                scoreType: "Grading Scale 0-5",
                                points: "1.50 / 2.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Open House",
                                type: "Participation and Engagement",
                                date: "9/16/2022",
                                due: "9/16/2022",
                                score: "Not Graded",
                                scoreType: "Credit/No Credit",
                                points: "0.0000 Points Possible",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Story Analysis",
                                type: "Assignments/Assessments",
                                date: "9/12/2022",
                                due: "9/12/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "1.90 / 2.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "\"Yellow Wallpaper\" Analysis",
                                type: "Assignments/Assessments",
                                date: "9/6/2022",
                                due: "9/6/2022",
                                score: "3",
                                scoreType: "Grading Scale 0-5",
                                points: "0.85 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Literary Period Timeline (Will work on in class 8/23-8/26)",
                                type: "Participation and Engagement",
                                date: "8/31/2022",
                                due: "8/31/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "0.95 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Image Stories",
                                type: "Assignments/Assessments",
                                date: "8/19/2022",
                                due: "8/19/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "0.95 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "\"Theme for English B\"",
                                type: "Assignments/Assessments",
                                date: "8/17/2022",
                                due: "8/17/2022",
                                score: "5",
                                scoreType: "Grading Scale 0-5",
                                points: "1.00 / 1.0000",
                                notes: "",
                                description: "Submit a page about you. You may use this poem as a model. You can make an acrostic poem using your name, write an essay, write a letter, create a collage, etc. Be creative. Please bring a hard copy if you're able!&amp;#xD;&amp;#xA; Available in Google Classroom (https://classroom.google.com/c/NTM3NjI2OTYxNzc0/a/NDk3MzAxODQxMDI3/details).",
                                resources: []
                            )
                        ]
                    ),
                    Mark(
                        name: "S1 Exam",
                        scoreString: "N/A",
                        scoreRaw: "0.0",
                        gradeCalculationSumary: [
                            GradeCalculationPart(
                                name: "TOTAL",
                                weight: "100%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "N/A",
                                weightedPct: "100.00%"
                            ),
                            GradeCalculationPart(
                                name: "AP Practice",
                                weight: "10%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            ),
                            GradeCalculationPart(
                                name: "Final Exam",
                                weight: "15%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            ),
                            GradeCalculationPart(
                                name: "Participation and Engagement",
                                weight: "15%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            ),
                            GradeCalculationPart(
                                name: "Assignments/Assessments",
                                weight: "60%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            )
                        ],
                        assignments: []
                    ),
                    Mark(
                        name: "S1 Grade",
                        scoreString: "B",
                        scoreRaw: "85.1",
                        gradeCalculationSumary: [
                            GradeCalculationPart(
                                name: "TOTAL",
                                weight: "100%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "B",
                                weightedPct: "100.00%"
                            ),
                            GradeCalculationPart(
                                name: "AP Practice",
                                weight: "10%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            ),
                            GradeCalculationPart(
                                name: "Final Exam",
                                weight: "15%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            ),
                            GradeCalculationPart(
                                name: "Participation and Engagement",
                                weight: "15%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            ),
                            GradeCalculationPart(
                                name: "Assignments/Assessments",
                                weight: "60%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            )
                        ],
                        assignments: []
                    )
                ]
            ),
            Course(
                period: "5",
                title: "AP Macroeconomics",
                room: "486",
                staff: "Adam Smith",
                staffEmail: "smith@school.edu",
                marks: [
                    Mark(
                        name: "3rd 6 Wk",
                        scoreString: "A+",
                        scoreRaw: "100.0",
                        gradeCalculationSumary: [],
                        assignments: [
                            Assignment(
                                name: "Module 37 Long-Run growth",
                                type: "Homework",
                                date: "11/16/2022",
                                due: "11/16/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Module 38",
                                type: "Homework",
                                date: "11/16/2022",
                                due: "11/16/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Module 39 Growth policy",
                                type: "Homework",
                                date: "11/16/2022",
                                due: "11/16/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Module 40 Growth in models",
                                type: "Homework",
                                date: "11/16/2022",
                                due: "11/16/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "WS 37",
                                type: "Assignment",
                                date: "11/16/2022",
                                due: "11/16/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "WS 38",
                                type: "Assignment",
                                date: "11/16/2022",
                                due: "11/16/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "AP Expectations",
                                type: "Participation",
                                date: "11/3/2022",
                                due: "11/3/2022",
                                score: "Not Graded",
                                scoreType: "Raw Score",
                                points: "100.0000 Points Possible",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Module 30: Long-Run",
                                type: "Homework",
                                date: "11/3/2022",
                                due: "11/3/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Module 31: Monetary Policy",
                                type: "Homework",
                                date: "11/3/2022",
                                due: "11/3/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Module 32: Money",
                                type: "Homework",
                                date: "11/3/2022",
                                due: "11/3/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Module 33 Inflation",
                                type: "Homework",
                                date: "11/3/2022",
                                due: "11/3/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Module 34 Inflation and Unemployment",
                                type: "Homework",
                                date: "11/3/2022",
                                due: "11/3/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Module 36 Consensus",
                                type: "Homework",
                                date: "11/3/2022",
                                due: "11/3/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "WS 30",
                                type: "Assignment",
                                date: "11/3/2022",
                                due: "11/3/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "WS 31",
                                type: "Assignment",
                                date: "11/3/2022",
                                due: "11/3/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "WS 32",
                                type: "Assignment",
                                date: "11/3/2022",
                                due: "11/3/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "WS 33",
                                type: "Assignment",
                                date: "11/3/2022",
                                due: "11/3/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "WS 34",
                                type: "Assignment",
                                date: "11/3/2022",
                                due: "11/3/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "WS 35",
                                type: "Assignment",
                                date: "11/3/2022",
                                due: "11/3/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            )
                        ]
                    ),
                    Mark(
                        name: "S1 Exam",
                        scoreString: "N/A",
                        scoreRaw: "0.0",
                        gradeCalculationSumary: [],
                        assignments: []
                    ),
                    Mark(
                        name: "S1 Grade",
                        scoreString: "A+",
                        scoreRaw: "99.1",
                        gradeCalculationSumary: [],
                        assignments: []
                    )
                ]
            ),
            Course(
                period: "6",
                title: "AP Chemistry",
                room: "216",
                staff: "Watson Cricke",
                staffEmail: "w.cricke@school.edu",
                marks: [
                    Mark(
                        name: "3rd 6 Wk",
                        scoreString: "B",
                        scoreRaw: "85.1",
                        gradeCalculationSumary: [
                            GradeCalculationPart(
                                name: "Assignments/Assessments",
                                weight: "60%",
                                points: "15.35",
                                pointsPossible: "19.00",
                                calculatedMark: "B-",
                                weightedPct: "48.47%"
                            ),
                            GradeCalculationPart(
                                name: "Participation and Engagement",
                                weight: "15%",
                                points: "5.13",
                                pointsPossible: "5.00",
                                calculatedMark: "A+",
                                weightedPct: "15.38%"
                            ),
                            GradeCalculationPart(
                                name: "TOTAL",
                                weight: "100%",
                                points: "20.48",
                                pointsPossible: "24.00",
                                calculatedMark: "B",
                                weightedPct: "85.10%"
                            ),
                            GradeCalculationPart(
                                name: "AP Practice",
                                weight: "10%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            ),
                            GradeCalculationPart(
                                name: "Final Exam",
                                weight: "15%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            )
                        ],
                        assignments: [
                            Assignment(
                                name: "Extra Credit Assignment",
                                type: "Participation and Engagement",
                                date: "10/31/2022",
                                due: "10/31/2022",
                                score: "1",
                                scoreType: "Grading Scale 0-5",
                                points: "0.33 / 0.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Genetics Discussion",
                                type: "Participation and Engagement",
                                date: "10/28/2022",
                                due: "10/28/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "0.95 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Molar Worksheet",
                                type: "Assignments/Assessments",
                                date: "10/28/2022",
                                due: "10/28/2022",
                                score: "Not Graded",
                                scoreType: "Grading Scale 0-5",
                                points: "2.0000 Points Possible",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Titration Discussion",
                                type: "Participation and Engagement",
                                date: "10/21/2022",
                                due: "10/21/2022",
                                score: "5",
                                scoreType: "Grading Scale 0-5",
                                points: "1.00 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Titration Worksheet",
                                type: "Assignments/Assessments",
                                date: "10/18/2022",
                                due: "10/18/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "2.85 / 3.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Stoichiometry Discussion",
                                type: "Participation and Engagement",
                                date: "10/14/2022",
                                due: "10/14/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "0.95 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Stoichiometry Worksheet",
                                type: "Assignments/Assessments",
                                date: "10/14/2022",
                                due: "10/14/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "1.90 / 2.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Acids and Bases Discussion",
                                type: "Participation and Engagement",
                                date: "10/5/2022",
                                due: "10/5/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "0.95 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Acids and Bases Worksheet",
                                type: "Assignments/Assessments",
                                date: "10/5/2022",
                                due: "10/5/2022",
                                score: "5",
                                scoreType: "Grading Scale 0-5",
                                points: "2.00 / 2.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Chemical Reactions Discussion",
                                type: "Assignments/Assessments",
                                date: "10/3/2022",
                                due: "10/3/2022",
                                score: "0.5",
                                scoreType: "Grading Scale 0-5",
                                points: "0.50 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Chemical Reactions Worksheet",
                                type: "Assignments/Assessments",
                                date: "9/30/2022",
                                due: "9/30/2022",
                                score: "0",
                                scoreType: "Grading Scale 0-5",
                                points: "0.00 / 2.0000",
                                notes: "Missing ",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Molecular Compounds Worksheet",
                                type: "Assignments/Assessments",
                                date: "9/23/2022",
                                due: "9/23/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "1.90 / 2.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Analysis Paragraph",
                                type: "Assignments/Assessments",
                                date: "9/16/2022",
                                due: "9/16/2022",
                                score: "2",
                                scoreType: "Grading Scale 0-5",
                                points: "1.50 / 2.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Open House",
                                type: "Participation and Engagement",
                                date: "9/16/2022",
                                due: "9/16/2022",
                                score: "Not Graded",
                                scoreType: "Credit/No Credit",
                                points: "0.0000 Points Possible",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Essay Analysis",
                                type: "Assignments/Assessments",
                                date: "9/12/2022",
                                due: "9/12/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "1.90 / 2.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Research Paper",
                                type: "Assignments/Assessments",
                                date: "9/6/2022",
                                due: "9/6/2022",
                                score: "3",
                                scoreType: "Grading Scale 0-5",
                                points: "0.85 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            )
                        ]
                    ),
                    Mark(
                        name: "S1 Exam",
                        scoreString: "N/A",
                        scoreRaw: "0.0",
                        gradeCalculationSumary: [
                            GradeCalculationPart(
                                name: "TOTAL",
                                weight: "100%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "N/A",
                                weightedPct: "100.00%"
                            ),
                            GradeCalculationPart(
                                name: "AP Practice",
                                weight: "10%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            ),
                            GradeCalculationPart(
                                name: "Final Exam",
                                weight: "15%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            ),
                            GradeCalculationPart(
                                name: "Participation and Engagement",
                                weight: "15%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            ),
                            GradeCalculationPart(
                                name: "Assignments/Assessments",
                                weight: "60%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            )
                        ],
                        assignments: []
                    ),
                    Mark(
                        name: "S1 Grade",
                        scoreString: "B",
                        scoreRaw: "85.1",
                        gradeCalculationSumary: [
                            GradeCalculationPart(
                                name: "TOTAL",
                                weight: "100%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "B",
                                weightedPct: "100.00%"
                            ),
                            GradeCalculationPart(
                                name: "AP Practice",
                                weight: "10%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            ),
                            GradeCalculationPart(
                                name: "Final Exam",
                                weight: "15%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            ),
                            GradeCalculationPart(
                                name: "Participation and Engagement",
                                weight: "15%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            ),
                            GradeCalculationPart(
                                name: "Assignments/Assessments",
                                weight: "60%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            )
                        ],
                        assignments: []
                    )
                ]
            ),
        ]
    )
    let singleMarkGradebook = Gradebook(
        reportingPeriods: [
            ReportPeriod(index: "0", name: "1st 6 Weeks", startDate: "8/10/2022", endDate: "9/16/2022"),
            ReportPeriod(index: "1", name: "2nd 6 Weeks", startDate: "9/19/2022", endDate: "11/1/2022"),
            ReportPeriod(index: "2", name: "3rd 6 Weeks", startDate: "11/2/2022", endDate: "12/20/2022"),
            ReportPeriod(index: "3", name: "4th 6 Weeks", startDate: "1/5/2023", endDate: "2/17/2023"),
            ReportPeriod(index: "4", name: "5th 6 Weeks", startDate: "2/21/2023", endDate: "4/14/2023"),
            ReportPeriod(index: "5", name: "6th 6 Weeks", startDate: "4/17/2023", endDate: "5/25/2023")
        ],
        reportingPeriod: ReportingPeriod(
            name: "3rd 6 Weeks",
            startDate: "11/2/2022",
            endDate: "12/20/2022"
        ),
        courses: [
            Course(
                period: "2",
                title: "AP Calculus BC",
                room: "492",
                staff: "John Leibniz",
                staffEmail: "leibniz@school.edu",
                marks: [
                    Mark(
                        name: "3rd 6 Wk",
                        scoreString: "A+",
                        scoreRaw: "100",
                        gradeCalculationSumary: [
                            GradeCalculationPart(
                                name: "Homework",
                                weight: "20%",
                                points: "70.00",
                                pointsPossible: "70.00",
                                calculatedMark: "A+",
                                weightedPct: "20.00%"
                            ),
                            GradeCalculationPart(
                                name: "TOTAL",
                                weight: "100%",
                                points: "70.00",
                                pointsPossible: "70.00",
                                calculatedMark: "A+",
                                weightedPct: "100.00%"
                            ),
                            GradeCalculationPart(
                                name: "Test",
                                weight: "50%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            ),
                            GradeCalculationPart(
                                name: "Quiz",
                                weight: "30%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            )
                        ],
                        assignments: [
                            Assignment(
                                name: "Week of Nov. 14th",
                                type: "Homework",
                                date: "11/17/2022",
                                due: "11/17/2022",
                                score: "20 out of 20.0000",
                                scoreType: "Raw Score",
                                points: "15.00 / 20.0000",
                                notes: "",
                                description: "Week of Nov. 14th",
                                resources: []
                            ),
                            Assignment(
                                name: "Week of Nov. 7th",
                                type: "Homework",
                                date: "11/14/2022",
                                due: "11/14/2022",
                                score: "20 out of 20.0000",
                                scoreType: "Raw Score",
                                points: "20.00 / 20.0000",
                                notes: "",
                                description: "Week of Nov. 7th",
                                resources: []
                            ),
                            Assignment(
                                name: "Week of Oct. 31st",
                                type: "Homework",
                                date: "11/7/2022",
                                due: "11/7/2022",
                                score: "30 out of 30.0000",
                                scoreType: "Raw Score",
                                points: "30.00 / 30.0000",
                                notes: "",
                                description: "Week of Oct. 31st",
                                resources: []
                            ),
                            Assignment(
                                name: "Quiz 1",
                                type: "Quiz",
                                date: "11/7/2022",
                                due: "11/7/2022",
                                score: "30 out of 30.0000",
                                scoreType: "Raw Score",
                                points: "30.00 / 30.0000",
                                notes: "",
                                description: "Week of Oct. 31st",
                                resources: []
                            )
                        ]
                    )
                ]
            ),
            Course(
                period: "3",
                title: "AP English Literature",
                room: "154",
                staff: "Virginia Woolf",
                staffEmail: "woolf.v@school.edu",
                marks: [
                    Mark(
                        name: "3rd 6 Wk",
                        scoreString: "B",
                        scoreRaw: "85.1",
                        gradeCalculationSumary: [
                            GradeCalculationPart(
                                name: "Assignments/Assessments",
                                weight: "60%",
                                points: "15.35",
                                pointsPossible: "19.00",
                                calculatedMark: "B-",
                                weightedPct: "48.47%"
                            ),
                            GradeCalculationPart(
                                name: "Participation and Engagement",
                                weight: "15%",
                                points: "5.13",
                                pointsPossible: "5.00",
                                calculatedMark: "A+",
                                weightedPct: "15.38%"
                            ),
                            GradeCalculationPart(
                                name: "TOTAL",
                                weight: "100%",
                                points: "20.48",
                                pointsPossible: "24.00",
                                calculatedMark: "B",
                                weightedPct: "85.10%"
                            ),
                            GradeCalculationPart(
                                name: "AP Practice",
                                weight: "10%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            ),
                            GradeCalculationPart(
                                name: "Final Exam",
                                weight: "15%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            )
                        ],
                        assignments: [
                            Assignment(
                                name: "Literary Costume Halloween",
                                type: "Participation and Engagement",
                                date: "10/31/2022",
                                due: "10/31/2022",
                                score: "1",
                                scoreType: "Grading Scale 0-5",
                                points: "0.33 / 0.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "1984 Part III Discussion",
                                type: "Participation and Engagement",
                                date: "10/28/2022",
                                due: "10/28/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "0.95 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "1984 Part IIII QCCQ",
                                type: "Assignments/Assessments",
                                date: "10/28/2022",
                                due: "10/28/2022",
                                score: "Not Graded",
                                scoreType: "Grading Scale 0-5",
                                points: "2.0000 Points Possible",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "1984 Part II Ch. 7-10 Discussion",
                                type: "Participation and Engagement",
                                date: "10/21/2022",
                                due: "10/21/2022",
                                score: "5",
                                scoreType: "Grading Scale 0-5",
                                points: "1.00 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "\"The Landlady\" Q1",
                                type: "Assignments/Assessments",
                                date: "10/18/2022",
                                due: "10/18/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "2.85 / 3.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "1984 Discussion Part II 1-6",
                                type: "Participation and Engagement",
                                date: "10/14/2022",
                                due: "10/14/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "0.95 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "1984 Pt II 1-6 QCCQ",
                                type: "Assignments/Assessments",
                                date: "10/14/2022",
                                due: "10/14/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "1.90 / 2.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "1984 Discussion Part I",
                                type: "Participation and Engagement",
                                date: "10/5/2022",
                                due: "10/5/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "0.95 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "1984 Pt 1 QCCQ",
                                type: "Assignments/Assessments",
                                date: "10/5/2022",
                                due: "10/5/2022",
                                score: "5",
                                scoreType: "Grading Scale 0-5",
                                points: "2.00 / 2.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Vonnegut QCQ",
                                type: "Assignments/Assessments",
                                date: "10/3/2022",
                                due: "10/3/2022",
                                score: "0.5",
                                scoreType: "Grading Scale 0-5",
                                points: "0.50 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Bradbury/Vonnegut TW",
                                type: "Assignments/Assessments",
                                date: "9/30/2022",
                                due: "9/30/2022",
                                score: "0",
                                scoreType: "Grading Scale 0-5",
                                points: "0.00 / 2.0000",
                                notes: "Missing ",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Bradbury Story Analysis",
                                type: "Assignments/Assessments",
                                date: "9/23/2022",
                                due: "9/23/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "1.90 / 2.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Analysis Paragraph",
                                type: "Assignments/Assessments",
                                date: "9/16/2022",
                                due: "9/16/2022",
                                score: "2",
                                scoreType: "Grading Scale 0-5",
                                points: "1.50 / 2.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Open House",
                                type: "Participation and Engagement",
                                date: "9/16/2022",
                                due: "9/16/2022",
                                score: "Not Graded",
                                scoreType: "Credit/No Credit",
                                points: "0.0000 Points Possible",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Story Analysis",
                                type: "Assignments/Assessments",
                                date: "9/12/2022",
                                due: "9/12/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "1.90 / 2.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "\"Yellow Wallpaper\" Analysis",
                                type: "Assignments/Assessments",
                                date: "9/6/2022",
                                due: "9/6/2022",
                                score: "3",
                                scoreType: "Grading Scale 0-5",
                                points: "0.85 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Literary Period Timeline (Will work on in class 8/23-8/26)",
                                type: "Participation and Engagement",
                                date: "8/31/2022",
                                due: "8/31/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "0.95 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Image Stories",
                                type: "Assignments/Assessments",
                                date: "8/19/2022",
                                due: "8/19/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "0.95 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "\"Theme for English B\"",
                                type: "Assignments/Assessments",
                                date: "8/17/2022",
                                due: "8/17/2022",
                                score: "5",
                                scoreType: "Grading Scale 0-5",
                                points: "1.00 / 1.0000",
                                notes: "",
                                description: "Submit a page about you. You may use this poem as a model. You can make an acrostic poem using your name, write an essay, write a letter, create a collage, etc. Be creative. Please bring a hard copy if you're able!&amp;#xD;&amp;#xA; Available in Google Classroom (https://classroom.google.com/c/NTM3NjI2OTYxNzc0/a/NDk3MzAxODQxMDI3/details).",
                                resources: []
                            )
                        ]
                    )
                ]
            ),
            Course(
                period: "5",
                title: "AP Macroeconomics",
                room: "486",
                staff: "Adam Smith",
                staffEmail: "smith@school.edu",
                marks: [
                    Mark(
                        name: "3rd 6 Wk",
                        scoreString: "A+",
                        scoreRaw: "100.0",
                        gradeCalculationSumary: [],
                        assignments: [
                            Assignment(
                                name: "Module 37 Long-Run growth",
                                type: "Homework",
                                date: "11/16/2022",
                                due: "11/16/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Module 38",
                                type: "Homework",
                                date: "11/16/2022",
                                due: "11/16/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Module 39 Growth policy",
                                type: "Homework",
                                date: "11/16/2022",
                                due: "11/16/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Module 40 Growth in models",
                                type: "Homework",
                                date: "11/16/2022",
                                due: "11/16/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "WS 37",
                                type: "Assignment",
                                date: "11/16/2022",
                                due: "11/16/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "WS 38",
                                type: "Assignment",
                                date: "11/16/2022",
                                due: "11/16/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "AP Expectations",
                                type: "Participation",
                                date: "11/3/2022",
                                due: "11/3/2022",
                                score: "Not Graded",
                                scoreType: "Raw Score",
                                points: "100.0000 Points Possible",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Module 30: Long-Run",
                                type: "Homework",
                                date: "11/3/2022",
                                due: "11/3/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Module 31: Monetary Policy",
                                type: "Homework",
                                date: "11/3/2022",
                                due: "11/3/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Module 32: Money",
                                type: "Homework",
                                date: "11/3/2022",
                                due: "11/3/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Module 33 Inflation",
                                type: "Homework",
                                date: "11/3/2022",
                                due: "11/3/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Module 34 Inflation and Unemployment",
                                type: "Homework",
                                date: "11/3/2022",
                                due: "11/3/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Module 36 Consensus",
                                type: "Homework",
                                date: "11/3/2022",
                                due: "11/3/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "WS 30",
                                type: "Assignment",
                                date: "11/3/2022",
                                due: "11/3/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "WS 31",
                                type: "Assignment",
                                date: "11/3/2022",
                                due: "11/3/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "WS 32",
                                type: "Assignment",
                                date: "11/3/2022",
                                due: "11/3/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "WS 33",
                                type: "Assignment",
                                date: "11/3/2022",
                                due: "11/3/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "WS 34",
                                type: "Assignment",
                                date: "11/3/2022",
                                due: "11/3/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "WS 35",
                                type: "Assignment",
                                date: "11/3/2022",
                                due: "11/3/2022",
                                score: "10 out of 10.0000",
                                scoreType: "Raw Score",
                                points: "10.00 / 10.0000",
                                notes: "",
                                description: "",
                                resources: []
                            )
                        ]
                    )
                ]
            ),
            Course(
                period: "6",
                title: "AP Chemistry",
                room: "216",
                staff: "Watson Cricke",
                staffEmail: "w.cricke@school.edu",
                marks: [
                    Mark(
                        name: "3rd 6 Wk",
                        scoreString: "B",
                        scoreRaw: "85.1",
                        gradeCalculationSumary: [
                            GradeCalculationPart(
                                name: "Assignments/Assessments",
                                weight: "60%",
                                points: "15.35",
                                pointsPossible: "19.00",
                                calculatedMark: "B-",
                                weightedPct: "48.47%"
                            ),
                            GradeCalculationPart(
                                name: "Participation and Engagement",
                                weight: "15%",
                                points: "5.13",
                                pointsPossible: "5.00",
                                calculatedMark: "A+",
                                weightedPct: "15.38%"
                            ),
                            GradeCalculationPart(
                                name: "TOTAL",
                                weight: "100%",
                                points: "20.48",
                                pointsPossible: "24.00",
                                calculatedMark: "B",
                                weightedPct: "85.10%"
                            ),
                            GradeCalculationPart(
                                name: "AP Practice",
                                weight: "10%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            ),
                            GradeCalculationPart(
                                name: "Final Exam",
                                weight: "15%",
                                points: "0.00",
                                pointsPossible: "0.00",
                                calculatedMark: "0",
                                weightedPct: "0.00%"
                            )
                        ],
                        assignments: [
                            Assignment(
                                name: "Extra Credit Assignment",
                                type: "Participation and Engagement",
                                date: "10/31/2022",
                                due: "10/31/2022",
                                score: "1",
                                scoreType: "Grading Scale 0-5",
                                points: "0.33 / 0.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Genetics Discussion",
                                type: "Participation and Engagement",
                                date: "10/28/2022",
                                due: "10/28/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "0.95 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Molar Worksheet",
                                type: "Assignments/Assessments",
                                date: "10/28/2022",
                                due: "10/28/2022",
                                score: "Not Graded",
                                scoreType: "Grading Scale 0-5",
                                points: "2.0000 Points Possible",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Titration Discussion",
                                type: "Participation and Engagement",
                                date: "10/21/2022",
                                due: "10/21/2022",
                                score: "5",
                                scoreType: "Grading Scale 0-5",
                                points: "1.00 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Titration Worksheet",
                                type: "Assignments/Assessments",
                                date: "10/18/2022",
                                due: "10/18/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "2.85 / 3.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Stoichiometry Discussion",
                                type: "Participation and Engagement",
                                date: "10/14/2022",
                                due: "10/14/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "0.95 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Stoichiometry Worksheet",
                                type: "Assignments/Assessments",
                                date: "10/14/2022",
                                due: "10/14/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "1.90 / 2.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Acids and Bases Discussion",
                                type: "Participation and Engagement",
                                date: "10/5/2022",
                                due: "10/5/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "0.95 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Acids and Bases Worksheet",
                                type: "Assignments/Assessments",
                                date: "10/5/2022",
                                due: "10/5/2022",
                                score: "5",
                                scoreType: "Grading Scale 0-5",
                                points: "2.00 / 2.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Chemical Reactions Discussion",
                                type: "Assignments/Assessments",
                                date: "10/3/2022",
                                due: "10/3/2022",
                                score: "0.5",
                                scoreType: "Grading Scale 0-5",
                                points: "0.50 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Chemical Reactions Worksheet",
                                type: "Assignments/Assessments",
                                date: "9/30/2022",
                                due: "9/30/2022",
                                score: "0",
                                scoreType: "Grading Scale 0-5",
                                points: "0.00 / 2.0000",
                                notes: "Missing ",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Molecular Compounds Worksheet",
                                type: "Assignments/Assessments",
                                date: "9/23/2022",
                                due: "9/23/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "1.90 / 2.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Analysis Paragraph",
                                type: "Assignments/Assessments",
                                date: "9/16/2022",
                                due: "9/16/2022",
                                score: "2",
                                scoreType: "Grading Scale 0-5",
                                points: "1.50 / 2.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Open House",
                                type: "Participation and Engagement",
                                date: "9/16/2022",
                                due: "9/16/2022",
                                score: "Not Graded",
                                scoreType: "Credit/No Credit",
                                points: "0.0000 Points Possible",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Essay Analysis",
                                type: "Assignments/Assessments",
                                date: "9/12/2022",
                                due: "9/12/2022",
                                score: "4",
                                scoreType: "Grading Scale 0-5",
                                points: "1.90 / 2.0000",
                                notes: "",
                                description: "",
                                resources: []
                            ),
                            Assignment(
                                name: "Research Paper",
                                type: "Assignments/Assessments",
                                date: "9/6/2022",
                                due: "9/6/2022",
                                score: "3",
                                scoreType: "Grading Scale 0-5",
                                points: "0.85 / 1.0000",
                                notes: "",
                                description: "",
                                resources: []
                            )
                        ]
                    )
                ]
            ),
        ]
    )
    let reportingPeriod = ReportingPeriod(
        name: "3rd 6 Weeks",
        startDate: "11/2/2022",
        endDate: "12/20/2022"
    )
    let reportPeriod = ReportPeriod(index: "0", name: "1st 6 Weeks", startDate: "8/10/2022", endDate: "9/16/2022")
    let singleMarkCourse = Course(
        period: "2",
        title: "AP Calculus BC",
        room: "492",
        staff: "John Leibniz",
        staffEmail: "leibniz@school.edu",
        marks: [
            Mark(
            name: "3rd 6 Wk",
            scoreString: "A+",
            scoreRaw: "100",
            gradeCalculationSumary: [
                GradeCalculationPart(
                    name: "Homework",
                    weight: "20%",
                    points: "70.00",
                    pointsPossible: "70.00",
                    calculatedMark: "A+",
                    weightedPct: "20.00%"
                ),
                GradeCalculationPart(
                    name: "TOTAL",
                    weight: "100%",
                    points: "70.00",
                    pointsPossible: "70.00",
                    calculatedMark: "A+",
                    weightedPct: "100.00%"
                ),
                GradeCalculationPart(
                    name: "Test",
                    weight: "50%",
                    points: "0.00",
                    pointsPossible: "0.00",
                    calculatedMark: "0",
                    weightedPct: "0.00%"
                ),
                GradeCalculationPart(
                    name: "Quiz",
                    weight: "30%",
                    points: "0.00",
                    pointsPossible: "0.00",
                    calculatedMark: "0",
                    weightedPct: "0.00%"
                )
            ],
            assignments: [
                Assignment(
                    name: "Week of Nov. 14th",
                    type: "Homework",
                    date: "11/17/2022",
                    due: "11/17/2022",
                    score: "20 out of 20.0000",
                    scoreType: "Raw Score",
                    points: "15.00 / 20.0000",
                    notes: "",
                    description: "Week of Nov. 14th",
                    resources: []
                ),
                Assignment(
                    name: "Week of Nov. 7th",
                    type: "Homework",
                    date: "11/14/2022",
                    due: "11/14/2022",
                    score: "20 out of 20.0000",
                    scoreType: "Raw Score",
                    points: "20.00 / 20.0000",
                    notes: "",
                    description: "Week of Nov. 7th",
                    resources: []
                ),
                Assignment(
                    name: "Week of Oct. 31st",
                    type: "Homework",
                    date: "11/7/2022",
                    due: "11/7/2022",
                    score: "30 out of 30.0000",
                    scoreType: "Raw Score",
                    points: "30.00 / 30.0000",
                    notes: "",
                    description: "Week of Oct. 31st",
                    resources: []
                ),
                Assignment(
                    name: "Quiz 1",
                    type: "Quiz",
                    date: "11/7/2022",
                    due: "11/7/2022",
                    score: "30 out of 30.0000",
                    scoreType: "Raw Score",
                    points: "30.00 / 30.0000",
                    notes: "",
                    description: "Week of Oct. 31st",
                    resources: []
                )
            ]
        )
        ]
    )
    let multiMarkCourse = Course(
        period: "2",
        title: "AP Calculus BC",
        room: "492",
        staff: "John Leibniz",
        staffEmail: "leibniz@school.edu",
        marks: [
            Mark(
                name: "3rd 6 Wk",
                scoreString: "A+",
                scoreRaw: "100",
                gradeCalculationSumary: [
                    GradeCalculationPart(
                        name: "Homework",
                        weight: "20%",
                        points: "70.00",
                        pointsPossible: "70.00",
                        calculatedMark: "A+",
                        weightedPct: "20.00%"
                    ),
                    GradeCalculationPart(
                        name: "TOTAL",
                        weight: "100%",
                        points: "70.00",
                        pointsPossible: "70.00",
                        calculatedMark: "A+",
                        weightedPct: "100.00%"
                    ),
                    GradeCalculationPart(
                        name: "Test",
                        weight: "50%",
                        points: "0.00",
                        pointsPossible: "0.00",
                        calculatedMark: "0",
                        weightedPct: "0.00%"
                    ),
                    GradeCalculationPart(
                        name: "Quiz",
                        weight: "30%",
                        points: "0.00",
                        pointsPossible: "0.00",
                        calculatedMark: "0",
                        weightedPct: "0.00%"
                    )
                ],
                assignments: [
                    Assignment(
                        name: "Week of Nov. 14th",
                        type: "Homework",
                        date: "11/17/2022",
                        due: "11/17/2022",
                        score: "20 out of 20.0000",
                        scoreType: "Raw Score",
                        points: "15.00 / 20.0000",
                        notes: "",
                        description: "Week of Nov. 14th",
                        resources: []
                    ),
                    Assignment(
                        name: "Week of Nov. 7th",
                        type: "Homework",
                        date: "11/14/2022",
                        due: "11/14/2022",
                        score: "20 out of 20.0000",
                        scoreType: "Raw Score",
                        points: "20.00 / 20.0000",
                        notes: "",
                        description: "Week of Nov. 7th",
                        resources: []
                    ),
                    Assignment(
                        name: "Week of Oct. 31st",
                        type: "Homework",
                        date: "11/7/2022",
                        due: "11/7/2022",
                        score: "30 out of 30.0000",
                        scoreType: "Raw Score",
                        points: "30.00 / 30.0000",
                        notes: "",
                        description: "Week of Oct. 31st",
                        resources: []
                    ),
                    Assignment(
                        name: "Quiz 1",
                        type: "Quiz",
                        date: "11/7/2022",
                        due: "11/7/2022",
                        score: "30 out of 30.0000",
                        scoreType: "Raw Score",
                        points: "30.00 / 30.0000",
                        notes: "",
                        description: "Week of Oct. 31st",
                        resources: []
                    )
                ]
            ),
            Mark(
                name: "S1 Exam",
                scoreString: "N/A",
                scoreRaw: "0",
                gradeCalculationSumary: [
                    GradeCalculationPart(
                        name: "TOTAL",
                        weight: "100%",
                        points: "0.00",
                        pointsPossible: "0.00",
                        calculatedMark: "N/A",
                        weightedPct: "100.00%"
                    ),
                    GradeCalculationPart(
                        name: "Homework",
                        weight: "20%",
                        points: "0.00",
                        pointsPossible: "0.00",
                        calculatedMark: "0",
                        weightedPct: "0.00%"
                    ),
                    GradeCalculationPart(
                        name: "Test",
                        weight: "50%",
                        points: "0.00",
                        pointsPossible: "0.00",
                        calculatedMark: "0",
                        weightedPct: "0.00%"
                    ),
                    GradeCalculationPart(
                        name: "Quiz",
                        weight: "30%",
                        points: "0.00",
                        pointsPossible: "0.00",
                        calculatedMark: "0",
                        weightedPct: "0.00%"
                    )
                ],
                assignments: []
            ),
            Mark(
                name: "S1 Grade",
                scoreString: "A+",
                scoreRaw: "98",
                gradeCalculationSumary: [
                    GradeCalculationPart(
                        name: "TOTAL",
                        weight: "100%",
                        points: "0.00",
                        pointsPossible: "0.00",
                        calculatedMark: "A+",
                        weightedPct: "100.00%"
                    ),
                    GradeCalculationPart(
                        name: "Homework",
                        weight: "20%",
                        points: "0.00",
                        pointsPossible: "0.00",
                        calculatedMark: "0",
                        weightedPct: "0.00%"
                    ),
                    GradeCalculationPart(
                        name: "Test",
                        weight: "50%",
                        points: "0.00",
                        pointsPossible: "0.00",
                        calculatedMark: "0",
                        weightedPct: "0.00%"
                    ),
                    GradeCalculationPart(
                        name: "Quiz",
                        weight: "30%",
                        points: "0.00",
                        pointsPossible: "0.00",
                        calculatedMark: "0",
                        weightedPct: "0.00%"
                    )
                ],
                
                assignments: []
            )
        ]
    )
    let mark = Mark(
        name: "3rd 6 Wk",
        scoreString: "A+",
        scoreRaw: "100",
        gradeCalculationSumary: [
            GradeCalculationPart(
                name: "Homework",
                weight: "20%",
                points: "70.00",
                pointsPossible: "70.00",
                calculatedMark: "A+",
                weightedPct: "20.00%"
            ),
            GradeCalculationPart(
                name: "TOTAL",
                weight: "100%",
                points: "70.00",
                pointsPossible: "70.00",
                calculatedMark: "A+",
                weightedPct: "100.00%"
            ),
            GradeCalculationPart(
                name: "Test",
                weight: "50%",
                points: "0.00",
                pointsPossible: "0.00",
                calculatedMark: "0",
                weightedPct: "0.00%"
            ),
            GradeCalculationPart(
                name: "Quiz",
                weight: "30%",
                points: "0.00",
                pointsPossible: "0.00",
                calculatedMark: "0",
                weightedPct: "0.00%"
            )
        ],
        assignments: [
            Assignment(
                name: "Week of Nov. 14th",
                type: "Homework",
                date: "11/17/2022",
                due: "11/17/2022",
                score: "20 out of 20.0000",
                scoreType: "Raw Score",
                points: "15.00 / 20.0000",
                notes: "",
                description: "Week of Nov. 14th",
                resources: []
            ),
            Assignment(
                name: "Week of Nov. 7th",
                type: "Homework",
                date: "11/14/2022",
                due: "11/14/2022",
                score: "20 out of 20.0000",
                scoreType: "Raw Score",
                points: "20.00 / 20.0000",
                notes: "",
                description: "Week of Nov. 7th",
                resources: []
            ),
            Assignment(
                name: "Week of Oct. 31st",
                type: "Homework",
                date: "11/7/2022",
                due: "11/7/2022",
                score: "30 out of 30.0000",
                scoreType: "Raw Score",
                points: "30.00 / 30.0000",
                notes: "",
                description: "Week of Oct. 31st",
                resources: []
            ),
            Assignment(
                name: "Quiz 1",
                type: "Quiz",
                date: "11/7/2022",
                due: "11/7/2022",
                score: "30 out of 30.0000",
                scoreType: "Raw Score",
                points: "30.00 / 30.0000",
                notes: "",
                description: "Week of Oct. 31st",
                resources: []
            )
        ]
    )
    let gradeCalculationPart = GradeCalculationPart(
        name: "Homework",
        weight: "20%",
        points: "70.00",
        pointsPossible: "70.00",
        calculatedMark: "A+",
        weightedPct: "20.00%"
    )
    let assignment = Assignment(
        name: "Week of Nov. 14th",
        type: "Homework",
        date: "11/17/2022",
        due: "11/17/2022",
        score: "20 out of 20.0000",
        scoreType: "Raw Score",
        points: "15.00 / 20.0000",
        notes: "",
        description: "Week of Nov. 14th",
        resources: []
    )
    
    // District Info
    let districtList = DistrictList(districtInfos: [
        DistrictInfo(districtID: "", name: "Synergy School District", address: "East Fayetteville NC 28303", url: "https://mystudentlogin.school.edu"),
        DistrictInfo(districtID: "", name: "Oakwood School District ", address: "Oakwood NC 19735", url: "https://oakwood.school.com/"),
        DistrictInfo(districtID: "", name: "Horsefoot School District", address: "Horsefoot NC 57135", url: "https://horsefoot.school.com/"),
        DistrictInfo(districtID: "", name: "Pennyworth County Schools", address: "Pennyworth NC 48451", url: "https://pennyworth.school.com/"),
        DistrictInfo(districtID: "", name: "Ironsmith Municipal Schools", address: "Ironsmith NC 11548", url: "https://ironsmith.school.com/")
    ])
    let districtInfo = DistrictInfo(
        districtID: "",
        name: "Synergy School District",
        address: "East Fayetteville NC 28303",
        url: "https://mystudentlogin.school.edu"
    )
    
    // Student Info
    let studentInfo = StudentInfo(
        formattedName: "Lenna Hillard",
        permId: "27781647 ",
        gender: "Female",
        grade: "12",
        address: "2014 Forest Hills Dr&amp;lt;br&amp;gt;Fayetteville, NC 28303",
        birthDate: "07/14/2005",
        email: "27781647@SCHOOL.EDU",
        phone: "703-754-9697",
        homeLanguage: "",
        currentSchool: "Synergy High School",
        homeRoomTeacher: "Max Rega",
        homeRoomTeacherEmail: "rega@school.edu",
        homeRoomNumber: "504",
        counselorName: "",
        counselorEmail: "",
        base64Photo: "",
        emergencyContacts: [
            EmergencyContact(name: "Lonnie Pott", relationship: "Grandmother", homePhone: "423-788-9310", workPhone: "", otherPhone: "", mobilePhone: "917-253-8519"),
            EmergencyContact(name: "Armando Stuenkel", relationship: "Friend", homePhone: "510-463-1836", workPhone: "228-575-6049", otherPhone: "", mobilePhone: ""),
            EmergencyContact(name: "Liz Gunnerson", relationship: "Friend", homePhone: "", workPhone: "", otherPhone: "", mobilePhone: "903-840-2955")
        ],
        physician: Physician(name: "Dakota Galofaro", hospital: "University of Health and Wellness", phone: "703-239-0831", extn: ""),
        dentist: Dentist(name: "Zada Styer", office: "Styer Pediatric Dentistry", phone: "570-248-3380", extn: ""),
        userDefinedGroupBoxes: [
            UserDefinedGroupBox(userDefinedItems: [
                UserDefinedItem(itemLabel: "State ID#", value: "561985467"),
                UserDefinedItem(itemLabel: "Pick Up Bus Stop", value: "FOREST HILLS DR&amp;amp; MOUNTAIN VALLEY RD NE"),
                UserDefinedItem(itemLabel: "Bus Route To School", value: "0210"),
                UserDefinedItem(itemLabel: "Pick Up Transport Time", value: "6:33 AM"),
                UserDefinedItem(itemLabel: "Drop Off Transport Time", value: "2:41 PM")
            ])
        ]
    )
    let emergencyContact = EmergencyContact(
        name: "Lonnie Pott",
        relationship: "Grandmother",
        homePhone: "423-788-9310",
        workPhone: "",
        otherPhone: "",
        mobilePhone: "917-253-8519"
    )
    let physician = Physician(
        name: "Dakota Galofaro",
        hospital: "University of Health and Wellness",
        phone: "703-239-0831",
        extn: ""
    )
    let dentist = Dentist(
        name: "Zada Styer",
        office: "Styer Pediatric Dentistry",
        phone: "570-248-3380",
        extn: ""
    )
    let userDefinedItem = UserDefinedItem(
        itemLabel: "State ID#",
        value: "561985467"
    )
    
    // Schedule
    let schedule = Schedule(
        termIndex: "0",
        termIndexName: "Sem 1",
        todaySchedule: TodayScheduleInfoData(
            date: "10/19/2022",
            schoolInfos: [
                SchoolInfo(
                    name: "Elective Building",
                    bellScheduleName: "Wed",
                    classes: [
                        ClassInfo(
                            period: "02",
                            className: "AP Chemistry",
                            startTime: "12:20 PM",
                            endTime: "1:50 PM",
                            teacher: "Cricke, Watson",
                            roomName: "216",
                            teacherEmail: "w.cricke@school.edu",
                            endDate: "10/19/2022 1:50:00 PM",
                            startDate: "10/19/2022 PM"
                        )
                    ]
                ),
                SchoolInfo(
                    name: "Synergy High School",
                    bellScheduleName: "W/F 1357",
                    classes: [
                        ClassInfo(
                            period: "01",
                            className: "Off Campus",
                            startTime: "7:25 AM",
                            endTime: "8:17 AM",
                            teacher: "Domagall, Mitchel",
                            roomName: "NA",
                            teacherEmail: "domagall_m@school.edu",
                            endDate: "10/19/2022 8:17:00 AM",
                            startDate: "10/19/2022 7:25:00 AM"
                        ),
                        ClassInfo(
                            period: "03",
                            className: "AP English Literature",
                            startTime: "8:24 AM",
                            endTime: "10:10 AM",
                            teacher: "Woolf, Virginia",
                            roomName: "154",
                            teacherEmail: "woolf.v@school.edu",
                            endDate: "10/19/2022 10:10:00 AM",
                            startDate: "10/19/2022 8:24:00 AM"
                        ),
                        ClassInfo(
                            period: "05",
                            className: "AP Macroeconomics",
                            startTime: "10:17 AM",
                            endTime: "12:00 PM",
                            teacher: "Smith, Adam",
                            roomName: "486",
                            teacherEmail: "smith@school.edu",
                            endDate: "10/19/2022 12:00:00 PM",
                            startDate: "10/19/2022 10:17:00 AM"
                        ),
                        ClassInfo(
                            period: "07",
                            className: "Elective Period 7",
                            startTime: "12:42 PM",
                            endTime: "2:25 PM",
                            teacher: "",
                            roomName: "ElectiveBuilding",
                            teacherEmail: "",
                            endDate: "10/19/2022 2:25:00 PM",
                            startDate: "10/19/2022 12:42:00 PM"
                        )
                    ]
                )
            ]
        ),
        classLists: [
            ClassListing(
                period: "1",
                courseTitle: "Off Campus",
                roomName: "NA",
                teacher: "Mitchel Domagall",
                teacherEmail: "domagall_m@school.edu"
            ),
            ClassListing(
                period: "2",
                courseTitle: "AP Calculus BC",
                roomName: "492",
                teacher: "John Leibniz",
                teacherEmail: "leibniz@school.edu"
            ),
            ClassListing(
                period: "3",
                courseTitle: "AP English Literature",
                roomName: "154",
                teacher: "Virginia Woolf",
                teacherEmail: "woolf.v@school.edu"
            ),
            ClassListing(
                period: "4",
                courseTitle: "Off Campus",
                roomName: "NA",
                teacher: "Mitchel Domagall",
                teacherEmail: "domagall_m@school.edu"
            ),
            ClassListing(
                period: "5",
                courseTitle: "AP Macroeconomics",
                roomName: "486",
                teacher: "Adam Smith",
                teacherEmail: "smith@school.edu"
            ),
            ClassListing(
                period: "6",
                courseTitle: "Elective Period 6",
                roomName: "ElectiveBuilding",
                teacher: "",
                teacherEmail: ""
            ),
            ClassListing(
                period: "7",
                courseTitle: "Elective Period 7",
                roomName: "ElectiveBuilding",
                teacher: "",
                teacherEmail: ""
            ),
            ClassListing(
                period: "10",
                courseTitle: "Advisory",
                roomName: "284",
                teacher: "Lucretia Cairns",
                teacherEmail: "cairns@school.edu"
            )
        ],
        termLists: [
            TermListing(
                termIndex: "0",
                termCode: "1",
                termName: "Sem 1",
                beginDate: "8/10/2022",
                endDate: "12/20/2022",
                termDefCodes: [
                    TermDefCode(termDefName: "S1"),
                    TermDefCode(termDefName: "YR")
                ]
            ),
            TermListing(
                termIndex: "1",
                termCode: "2",
                termName: "Sem 2",
                beginDate: "01/05/2023",
                endDate: "05/25/2023",
                termDefCodes: [
                    TermDefCode(termDefName: "S2"),
                    TermDefCode(termDefName: "YR")
                ]
            )
        ],
        concurrentClassSchedules: [
            ConcurrentClassSchedule(
                schoolName: "Elective Center",
                termIndex: "0",
                termIndexName: "Sem 1",
                classLists: [
                    ClassListing(
                        period: "2",
                        courseTitle: "AP Chemistry",
                        roomName: "216",
                        teacher: "Watson Cricke",
                        teacherEmail: "w.cricke@school.edu"
                    )
                ],
                termLists: [
                    TermListing(
                        termIndex: "0",
                        termCode: "1",
                        termName: "Sem 1",
                        beginDate: "8/10/2022",
                        endDate: "12/20/2022",
                        termDefCodes: [
                            TermDefCode(termDefName: "S1"),
                            TermDefCode(termDefName: "YR")
                        ]
                    ),
                    TermListing(
                        termIndex: "1",
                        termCode: "2",
                        termName: "Sem 2",
                        beginDate: "01/05/2023",
                        endDate: "05/25/2023",
                        termDefCodes: [
                            TermDefCode(termDefName: "S2"),
                            TermDefCode(termDefName: "YR")
                        ]
                    )
                ]
            )
        ]
    )
    let todayScheduleInfoData = TodayScheduleInfoData(
        date: "10/19/2022",
        schoolInfos: [
            SchoolInfo(
                name: "Elective Building",
                bellScheduleName: "Wed",
                classes: [
                    ClassInfo(
                        period: "02",
                        className: "AP Chemistry",
                        startTime: "12:20 PM",
                        endTime: "1:50 PM",
                        teacher: "Cricke, Watson",
                        roomName: "216",
                        teacherEmail: "w.cricke@school.edu",
                        endDate: "10/19/2022 1:50:00 PM",
                        startDate: "10/19/2022 PM"
                    )
                ]
            ),
            SchoolInfo(
                name: "Synergy High School",
                bellScheduleName: "W/F 1357",
                classes: [
                    ClassInfo(
                        period: "01",
                        className: "Off Campus",
                        startTime: "7:25 AM",
                        endTime: "8:17 AM",
                        teacher: "Domagall, Mitchel",
                        roomName: "NA",
                        teacherEmail: "domagall_m@school.edu",
                        endDate: "10/19/2022 8:17:00 AM",
                        startDate: "10/19/2022 7:25:00 AM"
                    ),
                    ClassInfo(
                        period: "03",
                        className: "AP English Literature",
                        startTime: "8:24 AM",
                        endTime: "10:10 AM",
                        teacher: "Woolf, Virginia",
                        roomName: "154",
                        teacherEmail: "woolf.v@school.edu",
                        endDate: "10/19/2022 10:10:00 AM",
                        startDate: "10/19/2022 8:24:00 AM"
                    ),
                    ClassInfo(
                        period: "05",
                        className: "AP Macroeconomics",
                        startTime: "10:17 AM",
                        endTime: "12:00 PM",
                        teacher: "Smith, Adam",
                        roomName: "486",
                        teacherEmail: "smith@school.edu",
                        endDate: "10/19/2022 12:00:00 PM",
                        startDate: "10/19/2022 10:17:00 AM"
                    ),
                    ClassInfo(
                        period: "07",
                        className: "Elective Period 7",
                        startTime: "12:42 PM",
                        endTime: "2:25 PM",
                        teacher: "",
                        roomName: "ElectiveBuilding",
                        teacherEmail: "",
                        endDate: "10/19/2022 2:25:00 PM",
                        startDate: "10/19/2022 12:42:00 PM"
                    )
                ]
            )
        ]
    )
    let schoolInfo = SchoolInfo(
        name: "Synergy High School",
        bellScheduleName: "W/F 1357",
        classes: [
            ClassInfo(
                period: "01",
                className: "Off Campus",
                startTime: "7:25 AM",
                endTime: "8:17 AM",
                teacher: "Domagall, Mitchel",
                roomName: "NA",
                teacherEmail: "domagall_m@school.edu",
                endDate: "10/19/2022 8:17:00 AM",
                startDate: "10/19/2022 7:25:00 AM"
            ),
            ClassInfo(
                period: "03",
                className: "AP English Literature",
                startTime: "8:24 AM",
                endTime: "10:10 AM",
                teacher: "Woolf, Virginia",
                roomName: "154",
                teacherEmail: "woolf.v@school.edu",
                endDate: "10/19/2022 10:10:00 AM",
                startDate: "10/19/2022 8:24:00 AM"
            ),
            ClassInfo(
                period: "05",
                className: "AP Macroeconomics",
                startTime: "10:17 AM",
                endTime: "12:00 PM",
                teacher: "Smith, Adam",
                roomName: "486",
                teacherEmail: "smith@school.edu",
                endDate: "10/19/2022 12:00:00 PM",
                startDate: "10/19/2022 10:17:00 AM"
            ),
            ClassInfo(
                period: "07",
                className: "Elective Period 7",
                startTime: "12:42 PM",
                endTime: "2:25 PM",
                teacher: "",
                roomName: "ElectiveBuilding",
                teacherEmail: "",
                endDate: "10/19/2022 2:25:00 PM",
                startDate: "10/19/2022 12:42:00 PM"
            )
        ]
    )
    let classInfo = ClassInfo(
        period: "01",
        className: "Off Campus",
        startTime: "7:25 AM",
        endTime: "8:17 AM",
        teacher: "Domagall, Mitchel",
        roomName: "NA",
        teacherEmail: "domagall_m@school.edu",
        endDate: "10/19/2022 8:17:00 AM",
        startDate: "10/19/2022 7:25:00 AM"
    )
    let classListing = ClassListing(
        period: "1",
        courseTitle: "Off Campus",
        roomName: "NA",
        teacher: "Mitchel Domagall",
        teacherEmail: "domagall_m@school.edu"
    )
    let termListing = TermListing(
        termIndex: "0",
        termCode: "1",
        termName: "Sem 1",
        beginDate: "8/10/2022",
        endDate: "12/20/2022",
        termDefCodes: [
            TermDefCode(termDefName: "S1"),
            TermDefCode(termDefName: "YR")
        ]
    )
    let concurrentClassSchedule = ConcurrentClassSchedule(
        schoolName: "Elective Center",
        termIndex: "0",
        termIndexName: "Sem 1",
        classLists: [
            ClassListing(
                period: "2",
                courseTitle: "AP Chemistry",
                roomName: "216",
                teacher: "Watson Cricke",
                teacherEmail: "w.cricke@school.edu"
            )
        ],
        termLists: [
            TermListing(
                termIndex: "0",
                termCode: "1",
                termName: "Sem 1",
                beginDate: "8/10/2022",
                endDate: "12/20/2022",
                termDefCodes: [
                    TermDefCode(termDefName: "S1"),
                    TermDefCode(termDefName: "YR")
                ]
            ),
            TermListing(
                termIndex: "1",
                termCode: "2",
                termName: "Sem 2",
                beginDate: "01/05/2023",
                endDate: "05/25/2023",
                termDefCodes: [
                    TermDefCode(termDefName: "S2"),
                    TermDefCode(termDefName: "YR")
                ]
            )
        ]
    )
}
