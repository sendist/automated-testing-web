Feature: Login to Swag Labs

  Background:
    Given User is on Swag Labs Login page

  @ValidAccount @TC01
  Scenario: Berhasil melakukan login dengan mengisi credential valid
    When User enters username as "standard_user" and password as "rahasia123"
    Then User should be logged in successfully

  @PasswordEmpty @TC02
  Scenario: Login gagal diakibatkan password tidak terisi
    When User enters username as "standard_user" and password as ""
    Then User should see an error message "You need Password !"

  @UsernameEmpty @TC03
  Scenario: Login gagal diakibatkan username tidak terisi
    When User enters username as "" and password as "rahasia123"
    Then User should see an error message "You need Username !"

  @UsernamePasswordInvalid @TC04
  Scenario Outline: Login gagal diakibatkan username dan password tidak terdaftar pada sistem
    When User enters username as "<username>" and password as "<password>"
    Then User should see an error message "<errorMessage>"

    Examples:
      | username      | password     | errorMessage                                           | test case        |
      | admin123    | admin321 | Username and password do not match any user in this service! | username password tidak terdaftar |

  @UsernamePasswordEmpty @TC05
  Scenario: Login gagal diakibatkan username dan password tidak terisi
    When User enters username as "" and password as ""
    Then User should see an error message "You need Username & Password!"

  @UsernamePasswordNotMatch @TC06
  Scenario Outline: Login gagal diakibatkan password tidak sesuai dengan username yang terdaftar pada sistem
    When User enters username as "<username>" and password as "<password>"
    Then User should see an error message "<errorMessage>"

    Examples:
      | username      | password     | errorMessage                   | test case        |
      | standar_user  | admin123     | Username and password do not match any user in this service ! | invalid password |

  @Logout @TC07
  Scenario: User Logout
    Given User was on dashboard page
    When User click hamburger menu
    And User Click Logout
    Then User navigate to login page