public with sharing class PS2PdfFormParserService {
    @InvocableMethod(label='Parse PDF Form' description='Sends PDF content to an external service to parse form data.')
    public static List<ParseResult> parsePdf(List<ParseRequest> requests) {
        List<ParseResult> results = new List<ParseResult>();

        for (ParseRequest req : requests) {
            String responseStr = '';

            try {
                // Retrieve the version of the file content
                ContentVersion cv = [
                    SELECT VersionData 
                    FROM ContentVersion 
                    WHERE ContentDocumentId = :req.contentDocumentId 
                    ORDER BY VersionNumber DESC 
                    LIMIT 1
                ];

                // Encode the file as Base64
                String base64Data = EncodingUtil.base64Encode(cv.VersionData);

                // Prepare JSON body
                Map<String, String> jsonBody = new Map<String, String>{
                    'base64Doc' => base64Data
                };
                String jsonPayload = JSON.serialize(jsonBody);

                // Make HTTP callout
                HttpRequest httpRequest = new HttpRequest();
                //httpRequest.setEndpoint('https://ps-demo-apis-73f75c52d464.herokuapp.com/parse-pdf-form');
                httpRequest.setEndpoint('callout:HerokuPDFFormUtils/parse-pdf-form');
                httpRequest.setMethod('POST');
                httpRequest.setHeader('Content-Type', 'application/json');
                //httpRequest.setHeader('x-api-key', 'a1c47e1f-5d90-4f0e-bf89-7f2b6f2d4d13');
                httpRequest.setBody(jsonPayload);

                Http http = new Http();
                HttpResponse httpResponse = http.send(httpRequest);

                responseStr = httpResponse.getBody();

            } catch (Exception e) {
                responseStr = 'Error: ' + e.getMessage();
                throw e;
            }

            results.add(new ParseResult(responseStr));
        }

        return results;
    }

    public class ParseRequest {
        @InvocableVariable(label='Content Document Id' required=true)
        public String contentDocumentId;
    }

    public class ParseResult {
        @InvocableVariable(label='Response')
        public String response;

        public ParseResult(String response) {
            this.response = response;
        }
    }

    // PS2PdfFormParserService.test('069KY000006TdJgYAK');    // 3613.pdf
    // 
    public static void test(String contentDocumentId) {
        List<ParseRequest> requests = new List<ParseRequest>();
        
        ParseRequest req = new ParseRequest();
        req.contentDocumentId = contentDocumentId;
        
        requests.add(req);
        
        List<ParseResult> results = PS2PdfFormParserService.parsePdf(requests);
        System.debug(results[0].response);
    }
}