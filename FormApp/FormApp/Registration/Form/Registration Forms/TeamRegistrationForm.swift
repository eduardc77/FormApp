//
//  TeamRegistrationForm.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/24/21.
//

final class TeamRegistrationForm: Form {
    //MARK: - Properties
    
    var userInfo: UserInfo = TeamRegistrationFormUserInfo()
    
    var teacherCoordinatorsCount = 2
    var studentParticipantsCount = 2
    
    var pages: [FormPage] = [
        FormPage(title: "Team Information",
                 formSections: [PageSection(name: "Team"),
                                PageSection(name: "Residence"),
                                PageSection(name: "School")]),
        
        FormPage(title: "Teachers Information",
                 formSections: [PageSection(name: "Main Teacher Coordinator"),
                                PageSection(name: "Secondary Teacher Coordinator"),
                                PageSection(name: "Complete Team")]),
        
        FormPage(title: "Students information",
                 formSections: [PageSection(name: "Student Leader"),
                                PageSection(name: "Student Participant 1"),
                                PageSection(name: "Student Participant 2"),
                                PageSection(name: "Complete Team")])
    ]
    
    //MARK: - Initialization
    
    init() {
        setupPageItems()
    }
    
    //MARK: - Private Methods
    
    func setupPageItems() {
        guard var userInfo = userInfo as? TeamRegistrationFormUserInfo else { return }
        //MARK: - Team Page
        
        // Team Section
        
        //Team Name
        let teamNameItem = PageItem(title: "Team name", placeholder: "Enter your team name")
        teamNameItem.value = userInfo.teamName
        teamNameItem.valueCompletion = { [weak teamNameItem] value in
            userInfo.teamName = value
            teamNameItem?.value = value
        }
        
        pages[0].formSections[0].items = [teamNameItem]
        
        // Residence Section
        
        //Team Country
        let teamCountryItem = PageItem(title: "Team country", placeholder: "Select an option", cellType: PageItemCellType.dropdown)
    
        teamCountryItem.pickerComponents = ["Romania", "United Kingdom", "Hungary", "Algeria", "Andorra", "Angola", "India", "Thailand"]
        teamCountryItem.value = userInfo.teamCountry
        teamCountryItem.valueCompletion = { [weak teamCountryItem] value in
            userInfo.teamName = value
            teamCountryItem?.value = value
        }
        
        //Team County
        let teamCountyItem = PageItem(title: "Team county", placeholder: "Select an option", cellType: PageItemCellType.dropdown)
        teamCountyItem.value = userInfo.teamCounty
        teamCountyItem.pickerComponents = ["Prahova", "Suceava", "Cluj", "Alba", "Brașov", "Timiș", "Iași", "Arad"]
        teamCountyItem.valueCompletion = { [weak teamCountyItem] value in
            userInfo.teamCounty = value
            teamCountyItem?.value = value
        }
        
        //Team City
        let teamCityItem = PageItem(title: "Team city", placeholder: "Select an option", cellType: PageItemCellType.dropdown)
        teamCityItem.value = userInfo.teamCity
        teamCityItem.pickerComponents = ["Cluj-Napoca", "Suceava", "Timișoara", "Alba-Iulia", "Arad", "Sibiu"]
        teamCityItem.valueCompletion = { [weak teamCityItem] value in
            userInfo.teamCity = value
            teamCityItem?.value = value
        }
        
        pages[0].formSections[1].items = [teamCountryItem, teamCountyItem, teamCityItem]
        
        // School Section
        
        //School Name
        let schoolNameItem = PageItem(title: "School name", placeholder: "Select an option", cellType: PageItemCellType.dropdown)
        schoolNameItem.value = userInfo.schoolName
        schoolNameItem.pickerComponents = ["Colegiul National Mihai Viteazul", "Suceava", "Timișoara", "Alba-Iulia", "Arad", "Sibiu"]
        schoolNameItem.valueCompletion = { [weak schoolNameItem] value in
            userInfo.schoolName = value
            schoolNameItem?.value = value
        }
        
        //School Address
        let schoolAddressItem = PageItem(title: "School address", placeholder: "e.g. Str. Biruinței nr. 203")
        schoolAddressItem.value = userInfo.schoolAddress
        schoolAddressItem.valueCompletion = { [weak schoolAddressItem] value in
            userInfo.schoolAddress = value
            schoolAddressItem?.value = value
        }
        
        //School Postal Code
        let schoolPostalCodeItem = PageItem(title: "School postal code", placeholder: "e.g. 077120")
        schoolPostalCodeItem.value = userInfo.schoolPostalCode
        schoolPostalCodeItem.uiProperties.keyboardType = .numberPad
        schoolPostalCodeItem.valueCompletion = { [weak schoolPostalCodeItem] value in
            userInfo.schoolPostalCode = value
            schoolPostalCodeItem?.value = value
        }
        
        //School Email
        let schoolEmailItem = PageItem(title: "School email", placeholder: "e.g. school@school.com")
        schoolEmailItem.value = userInfo.schoolEmail
        schoolEmailItem.uiProperties.keyboardType = .emailAddress
        schoolEmailItem.valueCompletion = { [weak schoolEmailItem] value in
            userInfo.schoolEmail = value
            schoolEmailItem?.value = value
        }
        
        // School Phone
        let schoolPhoneItem = PageItem(title: "School phone number", placeholder: "e.g. +40721 564 342")
        schoolPhoneItem.uiProperties.keyboardType = .phonePad
        schoolPhoneItem.value = userInfo.schoolPhone
        schoolPhoneItem.valueCompletion = { [weak schoolPhoneItem] value in
            userInfo.schoolPhone = value
            schoolPhoneItem?.value = value
        }
        
        // School Principal First Name
        let schoolPrincipalFirstNameItem = PageItem(title: "School principal first name", placeholder: "e.g. John")
        schoolPrincipalFirstNameItem.value = userInfo.schoolPrincipalFirstName
        schoolPrincipalFirstNameItem.valueCompletion = { [weak schoolPrincipalFirstNameItem] value in
            userInfo.schoolPrincipalFirstName = value
            schoolPrincipalFirstNameItem?.value = value
        }
        
        // School Principal Last Name
        let schoolPrincipalLastNameItem = PageItem(title: "School principal first name", placeholder: "e.g. Doe")
        schoolPrincipalLastNameItem.value = userInfo.schoolPrincipalLastName
        schoolPrincipalLastNameItem.valueCompletion = { [weak schoolPrincipalLastNameItem] value in
            userInfo.schoolPrincipalLastName = value
            schoolPrincipalLastNameItem?.value = value
        }
        
        pages[0].formSections[2].items = [schoolNameItem, schoolAddressItem, schoolPostalCodeItem, schoolEmailItem, schoolPhoneItem, schoolPrincipalFirstNameItem, schoolPrincipalLastNameItem]
        
        //MARK: - Teachers Page
        
        // Main Teacher Coordinator Section
        
        //First Name
        let mainCoordinatorFirstName = PageItem(title: "Coordinator first name", placeholder: "e.g. Jane")
        mainCoordinatorFirstName.value = userInfo.mainTeacherCoordinatorFirstName
        mainCoordinatorFirstName.uiProperties.cellType = PageItemCellType.textField
        mainCoordinatorFirstName.valueCompletion = { [weak mainCoordinatorFirstName] value in
            userInfo.mainTeacherCoordinatorFirstName = value
            mainCoordinatorFirstName?.value = value
        }
        
        //Last Name
        let mainCoordinatorLastNameItem = PageItem(title: "Coordinator last name", placeholder: "e.g. Doe")
        mainCoordinatorLastNameItem.value = userInfo.mainTeacherCoordinatorLastName
        mainCoordinatorLastNameItem.valueCompletion = { [weak mainCoordinatorLastNameItem] value in
            userInfo.mainTeacherCoordinatorLastName = value
            mainCoordinatorLastNameItem?.value = value
        }
        
        // Mail
        let mainCoordinatorEmailItem = PageItem(title: "Email", placeholder: "e.g. name.teacher@domain.com")
        mainCoordinatorEmailItem.uiProperties.keyboardType = .emailAddress
        mainCoordinatorEmailItem.value = userInfo.mainTeacherEmail
        mainCoordinatorEmailItem.valueCompletion = { [weak mainCoordinatorEmailItem] value in
            userInfo.mainTeacherEmail = value
            mainCoordinatorEmailItem?.value = value
        }
        
        // Phone Number
        let mainCoordinatorPhoneItem = PageItem(title: "Phone number", placeholder: "e.g. +40721 564 342")
        mainCoordinatorPhoneItem.uiProperties.keyboardType = .phonePad
        mainCoordinatorPhoneItem.value = userInfo.mainTeacherPhone
        mainCoordinatorPhoneItem.valueCompletion = { [weak mainCoordinatorPhoneItem] value in
            userInfo.mainTeacherPhone = value
            mainCoordinatorPhoneItem?.value = value
        }
        
        pages[1].formSections[0].items = [mainCoordinatorFirstName, mainCoordinatorLastNameItem, mainCoordinatorEmailItem, mainCoordinatorPhoneItem]
        
        // Secondary Teacher Coordinator Section
       
        // Secondary Teacher Coordinator Mail
        let secondaryTeacherEmailItem = PageItem(title: "Email", placeholder: "e.g. teacher.name@domain.com")
        secondaryTeacherEmailItem.uiProperties.keyboardType = .emailAddress
        secondaryTeacherEmailItem.value = userInfo.secondaryTeacherEmail
        secondaryTeacherEmailItem.valueCompletion = { [weak secondaryTeacherEmailItem] value in
            userInfo.secondaryTeacherEmail = value
            secondaryTeacherEmailItem?.value = value
        }
        
        pages[1].formSections[1].items = [secondaryTeacherEmailItem]
        
        //Complete Team Section
        
        // Teacher Coordinator 3 Section
       
        // Teacher Coordinator 3 Mail
        let teacher3EmailItem = PageItem(title: "Email", placeholder: "e.g. teacher.name@domain.com")
        teacher3EmailItem.uiProperties.keyboardType = .emailAddress
        teacher3EmailItem.isMandatory = false
        teacher3EmailItem.value = userInfo.teacher3Email
        teacher3EmailItem.valueCompletion = { [weak teacher3EmailItem] value in
            userInfo.teacher3Email = value
            teacher3EmailItem?.value = value
        }

        
        //Add a teacher coordinator
        let addTeacherItem = PageItem(title: "Add a teacher coordinator", cellType: .radioButton)
        addTeacherItem.segments = ["No", "Yes"]
        addTeacherItem.isMandatory = false
        addTeacherItem.valueCompletion = { [weak self, weak addTeacherItem] value in
            guard let self = self, value == "Yes", self.teacherCoordinatorsCount < 5 else {
                //TODO: - Maybe show alert when maximum number of coordinators has been reached.
                addTeacherItem?.currentSegmentIndex = 0
                return
            }
            
            addTeacherItem?.value = "No"
            addTeacherItem?.currentSegmentIndex = 0
            
            self.pages[1].formSections.insert(PageSection(name: "Teacher Coordinator \(self.teacherCoordinatorsCount + 1)"), at: self.teacherCoordinatorsCount)
            self.pages[1].formSections[self.teacherCoordinatorsCount].items.insert(teacher3EmailItem, at: self.pages[1].formSections[self.teacherCoordinatorsCount].items.count)
            
            self.teacherCoordinatorsCount += 1
        }
        
        pages[1].formSections[2].items = [addTeacherItem]
        
        //MARK: - Students Page
        
        // Student Leader Section
        
        // Student Leader Mail
        let studentLeaderEmailItem = PageItem(title: "Email", placeholder: "e.g. student.name@domain.com")
            studentLeaderEmailItem.uiProperties.keyboardType = .emailAddress
            studentLeaderEmailItem.uiProperties.isCellButtonHidden = false
            studentLeaderEmailItem.value = userInfo.studentLeaderEmail
            studentLeaderEmailItem.valueCompletion = { [weak studentLeaderEmailItem] value in
            userInfo.studentLeaderEmail = value
                studentLeaderEmailItem?.value = value
        }
        
        pages[2].formSections[0].items = [studentLeaderEmailItem]
        
        // Student Participant 1 Section
        
        // StudentParticipant 1 Mail
        let studentParticipant1EmailItem = PageItem(title: "Email", placeholder: "e.g. student.name@domain.com")
        studentParticipant1EmailItem.uiProperties.keyboardType = .emailAddress
        studentParticipant1EmailItem.uiProperties.isCellButtonHidden = false
        studentParticipant1EmailItem.value = userInfo.studentParticipant1Email
        studentParticipant1EmailItem.valueCompletion = { [weak studentParticipant1EmailItem] value in
            userInfo.studentParticipant1Email = value
            studentParticipant1EmailItem?.value = value
        }
        
        pages[2].formSections[1].items = [studentParticipant1EmailItem]
        
        // Student Participant 2 Section

        // StudentParticipant 2 Mail
        let studentParticipant2EmailItem = PageItem(title: "Email", placeholder: "e.g. student.name@domain.com")
        studentParticipant2EmailItem.uiProperties.keyboardType = .emailAddress
        studentParticipant2EmailItem.uiProperties.isCellButtonHidden = false
        studentParticipant2EmailItem.value = userInfo.studentParticipant2Email
        studentParticipant2EmailItem.valueCompletion = { [weak studentParticipant2EmailItem] value in
            userInfo.studentParticipant2Email = value
            studentParticipant2EmailItem?.value = value
        }
        
        // Student Participant 3 Section

        // StudentParticipant 3 Mail
        let studentParticipant3EmailItem = PageItem(title: "Email", placeholder: "e.g. student.name@domain.com")
        studentParticipant3EmailItem.isMandatory = false
        studentParticipant3EmailItem.uiProperties.keyboardType = .emailAddress
        studentParticipant3EmailItem.uiProperties.isCellButtonHidden = false
        studentParticipant3EmailItem.value = userInfo.studentParticipant3Email
        studentParticipant3EmailItem.valueCompletion = { [weak studentParticipant3EmailItem] value in
            userInfo.studentParticipant3Email = value
            studentParticipant3EmailItem?.value = value
        }
        
        pages[2].formSections[2].items = [studentParticipant2EmailItem]
    
        // Complete Team Section
        
        //Add A Student Participant
        let addStudentItem = PageItem(title: "Add a student participant", cellType: .radioButton)
        addStudentItem.segments = ["No", "Yes"]
        addStudentItem.isMandatory = false
        addStudentItem.valueCompletion = { [weak self, weak addStudentItem] value in
            guard let self = self, value == "Yes", self.studentParticipantsCount < 5 else {
                //TODO: - Maybe show alert when maximum number of coordinators has been reached.
                addStudentItem?.currentSegmentIndex = 0
                return
            }
            
            addStudentItem?.value = "No"
            addStudentItem?.currentSegmentIndex = 0
            
            self.pages[2].formSections.insert(PageSection(name: "Student Participant \(self.studentParticipantsCount + 1)"), at: self.studentParticipantsCount + 1)
    
            self.pages[2].formSections[self.studentParticipantsCount + 1].items.append(studentParticipant3EmailItem)
            
            self.studentParticipantsCount += 1
        }

        // Declaration Text
        let declarationTextItem = PageItem(cellType: .textView)
        declarationTextItem.value = "Declar că sunt conștient de consecințele completării eronate, voluntar sau involuntar, a oricăror date personale sau ale reprezentanților legali. Nota de informare și consimțământul primite pe email vor fi semnate de mine precum și de reprezentantul / reprezentanții legali (părinții) în situația în care sunt elev. Cunoașterea datelor de contract ale reprezentanților sunt obligatorii din punct de vedere legal și / sau pentru a putea fi contactați în situații neprevăzute."
        declarationTextItem.isMandatory = false
        
        // Accept Terms
        let checkboxItem = PageItem(cellType: .checkbox)
        checkboxItem.valueCompletion = { [weak checkboxItem] value in
            checkboxItem?.value = value
        }
        
        pages[2].formSections[studentParticipantsCount + 1].items = [addStudentItem, declarationTextItem, checkboxItem]
    }
}

struct TeamRegistrationFormUserInfo: UserInfo {
    //MARK: - Team Page
    
    // Team Section
    var teamName: String?
    
    // Residence Section
    var teamCountry: String?
    var teamCounty: String?
    var teamCity: String?
    
    // School Section
    var schoolName: String?
    var schoolAddress: String?
    var schoolPostalCode: String?
    var schoolEmail: String?
    var schoolPhone: String?
    var schoolPrincipalFirstName: String?
    var schoolPrincipalLastName: String?
    
    //MARK: - Teachers Page
    
    // Main Teacher Coordinator Section
    var mainTeacherCoordinatorFirstName: String?
    var mainTeacherCoordinatorLastName: String?
    var mainTeacherEmail: String?
    var mainTeacherPhone: String?
    
    // Secondary Teacher Coordinator Section
    var secondaryTeacherEmail: String?
    
    // Tertiary Teacher Coordinator Section
    var teacher3Email: String?
    
    //TODO: - Add more teacher coordinators
    
    //MARK: - Students Page
    
    // Student Leader Section
    var studentLeaderEmail: String?
    
    // Student Participant 1 Section
    var studentParticipant1Email: String?
    
    // Student Participant 2 Section
    var studentParticipant2Email: String?
    
    // Student Participant 3 Section
    var studentParticipant3Email: String?
    
    //TODO: -Add more participants
}
