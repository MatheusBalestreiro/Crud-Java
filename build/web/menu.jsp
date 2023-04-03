<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>CRUD</title>
        <!-- icon-->

        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="styles.css" rel="stylesheet" />
    </head>


    <body>
        <div class="d-flex" id="wrapper">
            <!-- Sidebar-->
            <div class="border-end bg-white" id="sidebar-wrapper">
                <div class="sidebar-heading border-bottom bg-light">CRUD <br> Matheus Balestreiro</div>
                <div class="list-group list-group-flush">
                    <a class="list-group-item list-group-item-action list-group-item-light p-3"
                       href="${pageContext.request.contextPath}/VeiculoListar">Listagem do Usuario</a>	
                    <a class="list-group-item list-group-item-action list-group-item-light p-3"
                       href="${pageContext.request.contextPath}/CidadeListar">Listagem da Cidade</a>	
                    <a class="list-group-item list-group-item-action list-group-item-light p-3"
                       href="${pageContext.request.contextPath}/EstadoListar">Listagem do Estado</a>	
                    <a class="list-group-item list-group-item-action list-group-item-light p-3"
                       href="${pageContext.request.contextPath}/DespesaListar">Listagem das Despesas</a>	
                </div>
            </div>



            <!-- Page content wrapper-->
            <div id="page-content-wrapper">
                <!-- Top navigation-->
                <!-- Page content-->
                <div class="container-fluid">

