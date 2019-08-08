require 'open-uri'
require 'pry'
require 'nokogiri'
require 'selenium-webdriver'


class Scraper

  def self.scrape_index_page(url)
    hash = {}
    scraped_students = []
    
    



    doc = Nokogiri::HTML(open("https://www.rentalcars.com/SearchResults.do?doYear=2019&puLocationType=location&serverName=&rateQualifier.frequentTravelerIDNumber=&fromFts=true&doCountryCode=us&driversAge=30&filterTo=20&countryCode=us&doMinute=0&rateQualifier.discountNbr=&puYear=2019&puSearchAgainInput=Cincinnati%2c+OH&puMinute=0&searchType=geosearch&doDay=9&filterFrom=0&coordinates=39.14799880981445%2c-84.47699737548828&puMonth=8&rateQualifier.rateCode=&carCategory=&doHour=10&puSearchInput=Cincinnati%2c+OH&rateQualifier.accountNo=&puDay=6&newSearchResults=true&puHour=10&preferred_company=&rateQualifier.partnerCode=&doMonth=8&filterName=CarCategorisationSupplierFilter"))
   

#doc.css("div.car-result-l.noBorder")[0].css("strong").text

    binding.pry
    doc.css("div.student-card").each do|student|
    
        hash = {
      :name => student.css("h4.student-name").text,
      :location => student.css("p.student-location").text,
      :profile_url => student.css("a").attr("href").value,
        }
        
        scraped_students << hash
    end
    return scraped_students
  end


  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))

    student_contacts = {}
    
    doc.css("div.social-icon-container")[0].css("a").each do |contact|
     student_contacts [:twitter]= contact.attr("href") if contact.attr("href").include?"twitter"
     student_contacts [:linkedin]= contact.attr("href") if contact.attr("href").include?"linkedin"
     student_contacts [:github]= contact.attr("href") if contact.attr("href").include?"github"
     student_contacts [:blog]= contact.attr("href") if contact.attr("href").include?"http:"    
    
    end
    
  #   student_contacts [:twitter]= 
  #       doc.css("div.social-icon-container")[0].css("a")[0].attr("href") if doc.css("div.social-icon-container")[0].css("a")[0] != nil

  #   student_contacts[:linkedin] = 
  #   doc.css("div.social-icon-container")[0].css("a")[1].attr("href") if doc.css("div.social-icon-container")[0].css("a")[1] != nil

  # student_contacts[:github] = 
  #     doc.css("div.social-icon-container")[0].css("a")[2].attr("href") if doc.css("div.social-icon-container")[0].css("a")[2] != nil 

  # student_contacts[:blog] = 
  #     doc.css("div.social-icon-container")[0].css("a")[3].attr("href") if doc.css("div.social-icon-container")[0].css("a")[3] != nil
       
    student_contacts[:profile_quote] = 
       doc.css("div.profile-quote").text
       
     student_contacts[:bio] = doc.css("div.description-holder p").text
    

    student_contacts = {
      :twitter =>  doc.css("div.social-icon-container")[0].css("a")[0].attr("href")} if doc.css("div.social-icon-container")[0].css("a")[0] != nil

    student_contacts = {
      :linkedin =>  doc.css("div.social-icon-container")[0].css("a")[1].attr("href")} if doc.css("div.social-icon-container")[0].css("a")[1] != nil

   student_contacts = {
      :github =>  doc.css("div.social-icon-container")[0].css("a")[2].attr("href")} if doc.css("div.social-icon-container")[0].css("a")[2] != nil 

   student_contacts = {
      :blog =>  doc.css("div.social-icon-container")[0].css("a")[3].attr("href")} if doc.css("div.social-icon-container")[0].css("a")[3] != nil
 
    student_contacts = {
      :profile_quote => doc.css("div.profile-quote").text,
      :bio => doc.css("div.description-holder p").text
    }
    

    return student_contacts 
  end

end

# studentName =doc.css("h4.student-name").text
# doc.css("div.student-card")[0].css("h4.student-name").text
# doc.css("div.student-card")[0].css("p.student-location").text
# url = doc.css("div.student-card")[0].css("a").attr("href").value


# twitter = doc.css("div.social-icon-container")[0].css("a")[0].attr("href")
#linkedin = doc.css("div.social-icon-container")[0].css("a")[1].attr("href")
#github = doc.css("div.social-icon-container")[0].css("a")[2].attr("href")
#blog = doc.css("div.social-icon-container")[0].css("a")[3].attr("href")
#profile quote = doc.css("div.profile-quote").text
#bio = doc.css("div.description-holder p").text
