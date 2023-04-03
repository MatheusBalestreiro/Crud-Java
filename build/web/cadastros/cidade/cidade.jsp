<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix = "fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="iso-8859-1"%>
<jsp:include page = "/header.jsp"/>
<jsp:include page="/menu.jsp"/>


<div class="container-fluid">
    <h1 class="h3 mb-2 mt-4 text-gray-800">Cidade</h1>
        <p class="mb-4">Planilha de Registros</p>
    <div class="card shadow">
            <div class="card-body">    
                <div class="col-8 panel-body">
                    <table id="datable" class="table table-striped table-bordered basic-datable">
                        <thead>
                            <tr>
                                <th align="left">ID</th>
                                <th align="left">Cidade</th>
                                <th align="left">Estado</th>
                                <th align="right">Status</th>
                                <th align="right">Alterar</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="cidade" items="${cidades}">
                                <tr>
                                    <td align="left">${cidade.idCidade}</td>
                                    <td align="left">${cidade.nomeCidade}</td>
                                    <td align="left">${cidade.estado.siglaEstado}</td>
                                    <td align="center">
                                        <a href="${pageContext.request.contextPath}/CidadeExcluir?idCidade=${cidade.idCidade}">
                                            <button class="btn btn-group-lg
                                                <c:out value="${cidade.situacao == 'A' ? 'btn-danger':'btn-success'}"/>">
                                                <c:out value="${cidade.situacao == 'A' ? 'Inativar': 'Ativar'}"/>
                                            </button>
                                        </a>
                                    </td>  
                                    <td align="center">
                                        <a href="${pageContext.request.contextPath}/CidadeCarregar?idCidade=${cidade.idCidade}">
                                            <button class="btn btn-group-lg btn-success"/> Alterar</button>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    <div align="center">
        <a class="btn btn-outline-success mb-4 mt-4" href="${pageContext.request.contextPath}/CidadeNovo">Novo</a>
        <a class="btn btn-outline-primary mb-4 mt-4" href="index.jsp">Menu</a>
    </div>   
</div>
<script>
        $(document).ready(function(){
            console.log('entrei ready');
            //carregamos a datable
            //$("#datable").DataTable({});
            $('#datable').DataTable({
                "oLanguage":{
                    "sProcessing": "Processando...",
                    "sLengthMenu": "Mostrar _MENU_registros",
                    "sZeroRecords": "Nenhum registro encontrado.",
                    "sInfo": "Mostrando de _START_ até _END_ de _TOTAL_ registros",
                    "sInfoEmpty": "Mostrando de 0 ate 0 de 0 registros",
                    "sInfoFiltered": "",
                    "sInfoPostFix": "",
                    "sSearch": "Buscar:",
                    "sUrl": "",
                    "oPaginate": {
                        "sFirst": "Primerio",
                        "sPrevious": "Anterior",
                        "sNext": "Seguinte",
                        "sLast": "Último"
                    }
                }
            });
        });
        
        </script>

<%@include file="/footer.jsp"%>

