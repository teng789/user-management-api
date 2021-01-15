type date_ddMMyyyy = Date {format: "dd-MM-yyyy"}
type date_yyyyMMdd = Date {format: "yyyy-MM-dd"}

fun mapRetrieveUsersResponse(userObj) =
	{
		"dateRegistered": (userObj."date_registered" as Date) as date_ddMMyyyy,
		"username": userObj."username",
		"fullName": userObj."full_name",
		"gender": getGenderValue(userObj."gender"),
		"age": dw::core::Periods::between(now(), (userObj."birthday" as Date)).years
	}
	
fun getGenderValue(genderCode) =
	if (upper(genderCode) == Mule::p("constants.gender.male.code"))
		Mule::p("constants.gender.male.value")
	else
		Mule::p("constants.gender.female.value")
		
fun getGenderCode(genderValue) =
	if (upper(genderValue) == upper(Mule::p("constants.gender.male.value")))
		Mule::p("constants.gender.male.code")
	else
		Mule::p("constants.gender.female.code")