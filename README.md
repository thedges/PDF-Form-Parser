# PDF-Form-Parser

THIS SOFTWARE IS COVERED BY [THIS DISCLAIMER](https://raw.githubusercontent.com/thedges/Disclaimer/master/disclaimer.txt).

This package includes an Apex class that can be utilized at Flow Action to send a content document to a PDF form parser and get back results in JSON format.

# Installation Instructions

<b>Here are steps to use this component:</b>
  1. Install the component per the **Deploy to Salesforce** button below
  2. Assign the "Heroku_PDF_Form_Utils" permission set to the users that will utilize this Apex class.
  3. In Setup, navigate to Named Credentials 
  4. Click on the tab named "External Credentials"
  5. Click on the item with label "HerokuPDFFormAPIKey"
  6. In the section named "Principals", edit the item named "apiKey"
  7. Create a new "Authentication Parameter"
     * The parameter name should be "apiKey" exactly
     * Enter the API key value (contact me directly to get this)
     ![alt text](https://github.com/thedges/PDF-Form-Parser/blob/master/ExternalCredental.jpg "External Credential")
  8. That should be it.
     * Checkout the flow labled "Test PDF Form Parse" for an example of it's use. You will need to update the "contentDocId" to include a document id in your demo org.
     
<a href="https://githubsfdeploy.herokuapp.com?owner=thedges&repo=PDF-Form-Parser&ref=main">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">
</a>
