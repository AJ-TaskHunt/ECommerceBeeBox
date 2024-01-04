<!DOCTYPE html>

<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Validation Example</title>
    <style>
        .error {
            color: red;
        }
    </style>
</head>
<body>
    <form id="myForm" runat="server">
        <!-- TextBox with onkeyup event -->
        <asp:TextBox ID="txtInput" runat="server" onkeyup="handleInput()" ClientIDMode="Static"></asp:TextBox>
        <span id="txtInputError" class="error"></span>

        <br />
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClientClick="return validateForm();" />

        <script type="text/javascript">
            function handleInput() {
                var input = document.getElementById('<%= txtInput.ClientID %>');
                var errorSpan = document.getElementById('txtInputError');

                // Check if the input is not empty
                if (input.value.trim() === '') {
                    errorSpan.innerText = 'Input is required';
                } else {
                    errorSpan.innerText = '';
                }
            }

            function validateForm() {
                var input = document.getElementById('<%= txtInput.ClientID %>');
                var errorSpan = document.getElementById('txtInputError');

                // Check if the input is not empty
                if (input.value.trim() === '') {
                    errorSpan.innerText = 'Input is required';
                    return false;
                } else {
                    errorSpan.innerText = '';
                    return true;
                }
            }
        </script>
    </form>
</body>
</html>