//
//  IndividualRegistrationForm.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/21/21.
//

enum Occupation: String {
    case Teacher
    case Student
}

final class IndividualRegistrationForm: Form {
    //MARK: - Properties
    
    var occupation: Occupation = .Teacher
    
    
    var userInfo: UserInfo = IndividualRegistrationFormUserInfo()
    
    var pages: [FormPage] = [
        FormPage(title: "Personal Information",
                 formSections: [PageSection(name: "Personal Information"),
                                PageSection(name: "Current Occupation"),
                                PageSection(name: "Diet / Religion"),
                                PageSection(name: "Residence")]),
        
        FormPage(title: "My School",
                 formSections: [PageSection(name: "My School")]),
        
        FormPage(title: "My Hobbies",
                 formSections: [PageSection(name: "Literature"),
                                PageSection(name: "Music"),
                                PageSection(name: "Movie")])
    ]
    
    //MARK: - Initialization
    
    init() {
        setupPageItems()
    }
    
    //MARK: - Private Methods
    
    func setupPageItems() {
        guard var userInfo = userInfo as? IndividualRegistrationFormUserInfo else { return }
        //MARK: - Personal Information Page
        
        //Personal Information Section
        
        // First Name
        let firstNameItem = PageItem(title: "First name", placeholder: "Enter your first name")
        firstNameItem.value = userInfo.firstName
        firstNameItem.valueCompletion = { [weak firstNameItem] value in
            userInfo.firstName = value
            firstNameItem?.value = value
        }
        
        // Last Name
        let lastNameItem = PageItem(title: "Last name", placeholder: "Enter your last name")
        lastNameItem.value = userInfo.lastName
        lastNameItem.valueCompletion = { [weak lastNameItem] value in
            userInfo.lastName = value
            lastNameItem?.value = value
        }
        
        // Mail
        let emailItem = PageItem(title: "Email", placeholder: "Enter you email address")
        emailItem.uiProperties.keyboardType = .emailAddress
        emailItem.value = userInfo.email
        emailItem.valueCompletion = { [weak emailItem] value in
            userInfo.email = value
            emailItem?.value = value
        }
        
        // Phone Number
        let phoneItem = PageItem(title: "Phone number", placeholder: "e.g. +40721 564 342")
        phoneItem.uiProperties.keyboardType = .phonePad
        phoneItem.value = userInfo.phoneNumber
        phoneItem.valueCompletion = { [weak phoneItem] value in
            userInfo.phoneNumber = value
            phoneItem?.value = value
        }
        
        // Gender
        let genderItem = PageItem(title: "Gender", cellType: .radioButton)
        genderItem.value = userInfo.gender
        genderItem.segments = ["Female", "Male", "Rather not say"]
        genderItem.valueCompletion = { [weak genderItem] value in
            userInfo.gender = value
            genderItem?.value = value
        }
        
        // Date of birth
        let dateItem = PageItem(title: "Date of birth", placeholder: "DD/MM/YYYY", cellType: PageItemCellType.datePicker)
        dateItem.value = userInfo.dateOfBirth
        dateItem.valueCompletion = { [weak dateItem] value in
            userInfo.dateOfBirth = value
            dateItem?.value = value
        }
        
        pages[0].formSections[0].items = [firstNameItem, lastNameItem, emailItem, phoneItem, genderItem, dateItem]
        
        // Current Occupation Section
        
        //MARK: - Teacher Items
        
        // School Subject
        let schoolSubjectItem = PageItem(title: "School subject", placeholder: "e.g. History",  cellType: .textField)
        schoolSubjectItem.value = userInfo.schoolSubject
        schoolSubjectItem.valueCompletion = { [weak schoolSubjectItem] value in
            userInfo.schoolSubject = value
            schoolSubjectItem?.value = value
        }
        
        //MARK: - Student Items
        
        // School Grade
        let schoolGradeItem = PageItem(title: "School grade", placeholder: "Select an option", cellType: PageItemCellType.dropdown)
        schoolGradeItem.value = userInfo.schoolGrade
        schoolGradeItem.pickerComponents = ["First Grade", "Second Grade", "Third Grade", "Fourth Grade", "Fifth Grade", "Sixth Grade", "Seventh Grade", "Eighth Grade", "Ninth Grade", "Tenth Grade"]
        schoolGradeItem.valueCompletion = { [weak schoolGradeItem] value in
            userInfo.schoolGrade = value
            schoolGradeItem?.value = value
        }
        
        //Personal Representative
        let personalRepresentativeItem = PageItem(title: "Personal representative", placeholder: "Select an option", cellType: PageItemCellType.dropdown)
        personalRepresentativeItem.value = userInfo.personalRepresentative
        personalRepresentativeItem.pickerComponents = ["Mother", "Father", "Legal Representative"]
        personalRepresentativeItem.valueCompletion = { [weak personalRepresentativeItem] value in
            userInfo.personalRepresentative = value
            personalRepresentativeItem?.value = value
        }
        
        // First Name
        let representativeFirstNameItem = PageItem(title: "First name", placeholder: "Enter your representative first name")
        representativeFirstNameItem.value = userInfo.representativeFirstName
        representativeFirstNameItem.uiProperties.cellType = PageItemCellType.textField
        representativeFirstNameItem.valueCompletion = { [weak representativeFirstNameItem] value in
            userInfo.representativeFirstName = value
            representativeFirstNameItem?.value = value
        }
        
        // Last Name
        let representativeLastNameItem = PageItem(title: "Last name", placeholder: "Enter your representative last name")
        representativeLastNameItem.value = userInfo.representativeLastName
        representativeLastNameItem.uiProperties.cellType = PageItemCellType.textField
        representativeLastNameItem.valueCompletion = { [weak representativeLastNameItem] value in
            userInfo.representativeLastName = value
            representativeLastNameItem?.value = value
        }
        
        // Phone Number
        let representativePhoneItem = PageItem(title: "Phone number", placeholder: "e.g. +40721 564 342")
        representativePhoneItem.uiProperties.keyboardType = .phonePad
        representativePhoneItem.value = userInfo.representativePhone
        representativePhoneItem.valueCompletion = { [weak representativePhoneItem] value in
            userInfo.representativePhone = value
            representativePhoneItem?.value = value
        }
        
        // Current Occupation
        let occupationItem = PageItem(title: "Current occupation", cellType: .radioButton)
        occupationItem.value = userInfo.currentOccupation
        occupationItem.segments = [Occupation.Teacher.rawValue, Occupation.Student.rawValue]
        occupationItem.valueCompletion = { [weak self, weak occupationItem] value in
            userInfo.currentOccupation = value
            occupationItem?.value = value
            
            guard let occupationItem = occupationItem, let self = self else { return }
            if value == Occupation.Teacher.rawValue {
                schoolGradeItem.value = nil
                userInfo.schoolGrade = nil
                personalRepresentativeItem.value = nil
                userInfo.personalRepresentative = nil
                representativeFirstNameItem.value = nil
                userInfo.representativeFirstName = nil
                representativeLastNameItem.value = nil
                userInfo.representativeLastName = nil
                representativePhoneItem.value = nil
                userInfo.representativePhone = nil
                
                self.pages[0].formSections[1].items = [occupationItem, schoolSubjectItem]
            } else if value == Occupation.Student.rawValue {
                schoolSubjectItem.value = nil
                userInfo.schoolSubject = nil
                
                self.pages[0].formSections[1].items = [occupationItem, schoolGradeItem, personalRepresentativeItem, representativeFirstNameItem, representativeLastNameItem, representativePhoneItem]
            }
        }
        
        pages[0].formSections[1].items = [occupationItem, schoolSubjectItem]
        
        // Diet / Religion Section
        
        // Diet
        let dietItem = PageItem(title: "Diet", placeholder: "Select an option", cellType: PageItemCellType.dropdown)
        dietItem.value = userInfo.diet
        dietItem.pickerComponents = ["Normal", "Vegetarian", "Vegan", "Low-Carb", "Low-Fat", "Atkins", "Ketogenic"]
        dietItem.valueCompletion = { [weak dietItem] value in
            userInfo.diet = value
            dietItem?.value = value
        }
        
        // Food Allergies
        let allergiesItem = PageItem(title: "Food allergies", placeholder: "Select an option", cellType: PageItemCellType.dropdown)
        allergiesItem.value = userInfo.foodAllergies
        allergiesItem.pickerComponents = ["Eggs", "Tree Nuts", "Peanuts", "Shellfish", "Wheat", "Soy", "Fish"]
        allergiesItem.valueCompletion = { [weak allergiesItem] value in
            userInfo.foodAllergies = value
            allergiesItem?.value = value
        }
        
        //Health Problems
        let healthProblemsItem = PageItem(title: "Other health problems", cellType: .radioButton)
        healthProblemsItem.value = userInfo.healthProblems
        healthProblemsItem.segments = ["No", "Yes"]
        healthProblemsItem.valueCompletion = { [weak healthProblemsItem] value in
            userInfo.healthProblems = value
            healthProblemsItem?.value = value
        }
        
        // Religion
        let religionItem = PageItem(title: "Religion", placeholder: "Select an option", cellType: PageItemCellType.dropdown)
        religionItem.value = userInfo.religion
        religionItem.pickerComponents = ["Eastern Orthodox", "Catholicism", "Protestantism", "Judaism", "Buddhism", "Islam", "Hinduism", "Scientology"]
        religionItem.valueCompletion = { [weak religionItem] value in
            userInfo.religion = value
            religionItem?.value = value
        }
        
        pages[0].formSections[2].items = [dietItem, allergiesItem, healthProblemsItem, religionItem]
        
        // Residence Section
        
        //Country of residence
        let countryItem = PageItem(title: "Country of residence", placeholder: "Select an option", cellType: PageItemCellType.dropdown)
        countryItem.value = userInfo.country
        countryItem.pickerComponents = ["Romania", "United Kingdom", "Hungary", "Algeria", "Andorra", "Angola", "India", "Thailand"]
        countryItem.valueCompletion = { [weak countryItem] value in
            userInfo.country = value
            countryItem?.value = value
        }
        
        //County of residence
        let countyItem = PageItem(title: "County of residence", placeholder: "Select an option", cellType: PageItemCellType.dropdown)
        countyItem.value = userInfo.county
        countyItem.pickerComponents = ["Prahova", "Suceava", "Cluj", "Alba", "Brașov", "Timiș", "Iași", "Arad"]
        countyItem.valueCompletion = { [weak countyItem] value in
            userInfo.county = value
            countyItem?.value = value
        }
        
        //City of residence
        let cityItem = PageItem(title: "City of residence", placeholder: "Select an option", cellType: PageItemCellType.dropdown)
        cityItem.value = userInfo.city
        cityItem.pickerComponents = ["Cluj-Napoca", "Suceava", "Timișoara", "Alba-Iulia", "Arad", "Sibiu"]
        cityItem.valueCompletion = { [weak cityItem] value in
            userInfo.city = value
            cityItem?.value = value
        }
        
        pages[0].formSections[3].items = [countryItem, countyItem, cityItem]
        
        //MARK: - My School Page
        
        //School Country
        let schoolCountryItem = PageItem(title: "School country", placeholder: "Select an option", cellType: PageItemCellType.dropdown)
        schoolCountryItem.value = userInfo.schoolCountry
        schoolCountryItem.pickerComponents = ["Romania", "United Kingdom", "Hungary", "Algeria", "Andorra", "Angola", "India", "Thailand"]
        schoolCountryItem.valueCompletion = { [weak schoolCountryItem] value in
            userInfo.schoolCountry = value
            schoolCountryItem?.value = value
        }
        
        //School County
        let schoolCountyItem = PageItem(title: "School county", placeholder: "Select an option", cellType: PageItemCellType.dropdown)
        schoolCountyItem.value = userInfo.schoolCounty
        schoolCountyItem.pickerComponents = ["Prahova", "Suceava", "Cluj", "Alba", "Brașov", "Timiș", "Iași", "Arad"]
        schoolCountyItem.valueCompletion = { [weak schoolCountyItem] value in
            userInfo.schoolCounty = value
            schoolCountyItem?.value = value
        }
        
        //School City
        let schoolCityItem = PageItem(title: "School city", placeholder: "Select an option", cellType: PageItemCellType.dropdown)
        schoolCityItem.value = userInfo.schoolCity
        schoolCityItem.pickerComponents = ["Cluj-Napoca", "Suceava", "Timișoara", "Alba-Iulia", "Arad", "Sibiu"]
        schoolCityItem.valueCompletion = { [weak schoolCityItem] value in
            userInfo.schoolCity = value
            schoolCityItem?.value = value
        }
        
        // School Name
        let schoolNameItem = PageItem(title: "School name", placeholder: "e.g. Colegiul National Mihai Viteazul",  cellType: .textField)
        schoolNameItem.value = userInfo.schoolName
        schoolNameItem.valueCompletion = { [weak schoolNameItem] value in
            userInfo.schoolName = value
            schoolNameItem?.value = value
        }
        
        // School Not Found
        let schoolNotFoundItem = PageItem(cellType: .textView)
        schoolNotFoundItem.value = "You did not find your school? \nRequest school registration!"
        schoolNotFoundItem.isMandatory = false
        
        pages[1].formSections[0].items = [schoolCountryItem, schoolCountyItem, schoolCityItem, schoolNameItem, schoolNotFoundItem]
        
        //MARK: - Hobbies Page
        
        // Literature Section
        
        // Favorite Book
        let favoriteBookItem = PageItem(title: "Favorite book", placeholder: "Enter your favorite book")
        favoriteBookItem.value = userInfo.favoriteBook
        favoriteBookItem.valueCompletion = { [weak favoriteBookItem] value in
            userInfo.favoriteBook = value
            favoriteBookItem?.value = value
        }
        
        // Favorite Book's Author
        let favoriteBooksAuthorItem = PageItem(title: "Favorite book's author", placeholder: "Enter the author of your favorite book")
        favoriteBooksAuthorItem.value = userInfo.favoriteBookAuthor
        favoriteBooksAuthorItem.valueCompletion = { [weak favoriteBooksAuthorItem] value in
            userInfo.favoriteBookAuthor = value
            favoriteBooksAuthorItem?.value = value
        }
        
        // Favorite Author
        let favoriteAuthorItem = PageItem(title: "Favorite author", placeholder: "Enter you favorite author")
        favoriteAuthorItem.value = userInfo.favoriteAuthor
        favoriteAuthorItem.valueCompletion = { [weak favoriteAuthorItem] value in
            userInfo.favoriteAuthor = value
            favoriteAuthorItem?.value = value
        }
        
        // Favorite Author's Book
        let favoriteAuthorsBookItem = PageItem(title: "Favorite author's book", placeholder: "Enter your favorite author's favorite book")
        favoriteAuthorsBookItem.value = userInfo.favoriteAuthorsFavoriteBook
        favoriteAuthorsBookItem.valueCompletion = { [weak favoriteAuthorsBookItem] value in
            userInfo.favoriteAuthorsFavoriteBook = value
            favoriteAuthorsBookItem?.value = value
        }
        
        pages[2].formSections[0].items = [favoriteBookItem, favoriteBooksAuthorItem, favoriteAuthorItem, favoriteAuthorsBookItem]
        
        //Music Section
        
        // Favorite Song
        let favoriteSongItem = PageItem(title: "Favorite song", placeholder: "Enter your favorite song")
        favoriteSongItem.value = userInfo.favoriteSong
        favoriteSongItem.valueCompletion = { [weak favoriteSongItem] value in
            userInfo.favoriteSong = value
            favoriteSongItem?.value = value
        }
        
        // Favorite Song's Artist
        let favoriteSongsArtistItem = PageItem(title: "Favorite song's artist", placeholder: "Enter the artist of your favorite song")
        favoriteSongsArtistItem.value = userInfo.favoriteSongsArtist
        favoriteSongsArtistItem.valueCompletion = { [weak favoriteSongsArtistItem] value in
            userInfo.favoriteSongsArtist = value
            favoriteSongsArtistItem?.value = value
        }
        
        // Favorite Artist / Band
        let favoriteArtistItem = PageItem(title: "Favorite artist / band", placeholder: "Enter you favorite artist / band")
        favoriteArtistItem.value = userInfo.favoriteArtist
        favoriteArtistItem.valueCompletion = { [weak favoriteArtistItem] value in
            userInfo.favoriteArtist = value
            favoriteArtistItem?.value = value
        }
        
        pages[2].formSections[1].items = [favoriteSongItem, favoriteSongsArtistItem, favoriteArtistItem]
        
        // Movie Section
        
        // Favorite Actor
        let favoriteActorItem = PageItem(title: "Favorite actor", placeholder: "Enter your favorite actor")
        favoriteActorItem.value = userInfo.favoriteActor
        favoriteActorItem.valueCompletion = { [weak favoriteActorItem] value in
            userInfo.favoriteActor = value
            favoriteActorItem?.value = value
        }
        
        // Favorite Movie
        let favoriteMovieItem = PageItem(title: "Favorite movie", placeholder: "Enter the artist of your favorite movie")
        favoriteMovieItem.value = userInfo.favoriteMovie
        favoriteMovieItem.valueCompletion = { [weak favoriteMovieItem] value in
            userInfo.favoriteMovie = value
            favoriteMovieItem?.value = value
        }
        
        // Declaration Text
        let declarationTextItem = PageItem(cellType: .textView)
        declarationTextItem.value = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        declarationTextItem.isMandatory = false
        
        // Accept Terms
        let checkboxItem = PageItem(cellType: .checkbox)
        checkboxItem.valueCompletion = { [weak checkboxItem] value in
            checkboxItem?.value = value
        }
        
        pages[2].formSections[2].items = [favoriteActorItem, favoriteMovieItem, declarationTextItem, checkboxItem]
    }
}

struct IndividualRegistrationFormUserInfo: UserInfo {
    //MARK: - General Information Page
    
    // Personal Information Section
    var firstName: String?
    var lastName: String?
    var email: String?
    var phoneNumber: String?
    var gender: String?
    var dateOfBirth: String?
    
    // Current Occupation Section
    var currentOccupation: String?
    
    //Teacher
    var schoolSubject: String?
    
    //Student
    var schoolGrade: String?
    var personalRepresentative: String?
    var representativeFirstName: String?
    var representativeLastName: String?
    var representativePhone: String?
    
    
    // Diet / Religion Section
    var diet: String?
    var foodAllergies: String?
    var healthProblems: String?
    var religion: String?
    
    // Residence Section
    var country: String?
    var county: String?
    var city: String?
    
    //MARK: - My School Page
    
    //My School Section
    var schoolCountry: String?
    var schoolCounty: String?
    var schoolCity: String?
    var schoolName: String?
    
    //MARK: - Hobbies Page
    
    // Literature Section
    var favoriteBook: String?
    var favoriteBookAuthor: String?
    var favoriteAuthor: String?
    var favoriteAuthorsFavoriteBook: String?
    
    // Music Section
    var favoriteSong: String?
    var favoriteSongsArtist: String?
    var favoriteArtist: String?
    
    //Movie Section
    var favoriteActor: String?
    var favoriteMovie: String?
}
