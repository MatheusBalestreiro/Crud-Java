<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="iso-8859-1" %>
<jsp:include page="/header.jsp"/>
<jsp:include page="/menu.jsp"/>


<div class="container-fluid">
    <h1 class="h3 mb-2 mt-4 text-gray-800">Estado</h1>
        <p class="mb-4">Planilha de Registros</p>


     <div class="card shadow">
            <div class="card-body">   
                <table id="datable" class="table table-striped table-bordered basic-datable">
                    <thead>
                        <tr>
                            <th align="left">ID</th>
                            <th align="left">Nome</th>
                            <th align="left">Sigla</th>
                            <th align="left">Excluir</th>
                            <th align="left">Alterar</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="estado" items="${estados}">
                            <tr>
                                <td align="left ">${estado.idEstado}</td>
                                <td align="left">${estado.nomeEstado}</td>
                                <td align="left">${estado.siglaEstado}</td>
                                <td align="center">
                                    <a class="btn btn-danger" href="#" id="deletar" title="Excluir" onclick="deletar(${estado.idEstado})">
                                        Excluir
                                    </a>
                                </td>
                                <td align="center">
                                    <a class="btn btn-success" href="
                                       ${pageContext.request.contextPath}/EstadoCarregar?idEstado=${estado.idEstado}">
                                        Alterar</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    <div align = "center">
        <a class="btn btn-outline-success mb-4 mt-4" href="${pageContext.request.contextPath}/EstadoNovo">Novo</a>
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
        
        function deletar(codigo){
        var id = codigo;
        console.log(codigo);
        Swal.fire({
            title: 'Vocé tem certeza?',
            text: "Vocé não podera recuperar depois!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Sim, apague o Estado!',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    type: 'post',
                    url: '${pageContext.request.contextPath}/EstadoExcluir',
                    data:{
                        idEstado: id
                    },
                    success:
                        function(data){
                            if(data == 1){
                                Swal.fire({
                                    position: 'center',
                                    icon: 'success',
                                    title: 'Sucesso',
                                    text: 'Estado excluido com sucesso!',
                                    showConfirmButton: false,
                                    timer: 1000
                                }) .then(function(){
                                window.location.href = "${pageContext.request.contextPath}/EstadoListar";
                            })
                            } else {
                                Swal.fire({
                                    position: 'center',
                                    icon: 'error',
                                    title: 'Erro',
                                    text: 'Não foi possível excluir o Estado!',
                                    showConfirmButton: false,
                                    timer: 1000
                                }) .then(function(){
                                window.location.href = "${pageContext.request.contextPath}/EstadoListar";
                            })
                            }
                        },
                    error:
                        function(data){
                            window.location.href = "${pageContext.request.contextPath}/EstadoListar";
                        }
                });
            };
        });
    }
        </script>
        
        <%@include file ="/footer.jsp" %>