class PaymentProcessing {
  static String url = "https://sandbox.talusconnect.com/tokenizer/tokenizer.js";
  static String pub_token = "pub_2oA71Q0iU0kzvwcmUUBOF85EWcy";

  static getHTMLString({String btnText = "Add Payment Method", bool isWeb = false}) {
    String htmlContent = """
<!DOCTYPE html>
<html>
  <head>
    <script language="javascript" src="$url"></script>
       <style>
      /* Style for the button */
      button {
        width: 100%; /* Full width */
        background-color: #003A4D; /* Red background */
        color: white; /* White text */
        padding: 8px 0; /* 6px vertical padding, 0 horizontal */
        margin: 8px 0; /* 6px top and bottom margin */
        border: none; /* No border */
          border-radius: 6px;
        font-size: 12px; /* Adjust font size */
        cursor: pointer; /* Pointer cursor on hover */
      }

      /* Button hover effect (optional) */
      button:hover {
        opacity: 0.9; /* Slight transparency on hover */
      }
    </style>
  </head>
  <body>
    <div id="container"></div>
    <button onclick="example.submit()">$btnText</button>
    <script>
      var example = new Tokenizer({
        url: '', 
        apikey: '$pub_token',
        container: '#container',
        submission: (resp) => { 
          const stringifiedResponse = JSON.stringify(resp);
          if($isWeb){
           paymentAddSubmissionCallBack('payment_add_submission: ' + stringifiedResponse);
          }else{
          console.log('payment_add_submission'+stringifiedResponse);
          }
        }
      });
    </script>
  </body>
</html>
""";
    return htmlContent;
  }
}
