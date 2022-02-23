<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="PaymentGateWay.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Razorpay</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
</head>
<body>
     <center>
        <form id="form1" runat="server">
            <input type="textbox" name="name" id="name" placeholder="Enter your name"/><br/><br/>
            <input type="textbox" name="amt" id="amt" placeholder="Enter amt"/><br/><br/>
            <input type="button" name="btnPayNow" id="btn" value="Pay Now" onclick="pay_now()"/>
        </form>
    </center>
    <script>
    function pay_now(){
        var name=jQuery('#name').val();
        var amt=jQuery('#amt').val();        
         jQuery.ajax({
             type:'post',
             url:'payment_process.aspx',
             data: "amt=" + amt + "&name=" + name,
             success:function(result){
                 var options = {
                     "key": "rzp_test_4WtXukJXO0OQa5",
                     "amount": amt*100, 
                     "currency": "INR",
                     "name": "Billy",
                     "description": "CheckOut Transaction",
                     "image": "https://i.ibb.co/6myys4W/logo-1.png",
                     "handler": function (response){
                         jQuery.ajax({
                             type:'post',
                             url:'payment_process.aspx',
                             data:"payment_id="+response.razorpay_payment_id,
                             success:function(result){
                               window.location.href ="success.aspx";
                             }
                         });
                     }
                 };
                 var rzp1 = new Razorpay(options);
                 rzp1.open();
            }
           });      
    }
    </script>
</body>
</html>