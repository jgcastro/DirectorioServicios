<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="DirectorioServicios.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:GridView ID="grd_usuarios" runat="server" AutoGenerateColumns="False" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Width="636px">
                <Columns>
                    <asp:BoundField DataField="ID_USUARIO" HeaderText="Id" />
                    <asp:BoundField DataField="NOMBRE_PROFESIONAL" HeaderText="Nombre" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
