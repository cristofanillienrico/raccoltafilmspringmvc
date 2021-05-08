<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!doctype html>
<html lang="it">
<head>
    <jsp:include page="../header.jsp"/>
    <title>Modifica elemento</title>

    <!-- style per le pagine diverse dalla index -->
    <link href="${pageContext.request.contextPath }/assets/css/global.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/jqueryUI/jquery-ui.min.css"/>
    <style>
        .ui-autocomplete-loading {
            background: white url("../assets/img/jqueryUI/anim_16x16.gif") right center no-repeat;
        }

        .error_field {
            color: red;
        }
    </style>
</head>
<body>
<jsp:include page="../navbar.jsp"/>

<main role="main" class="container">

    <%-- se l'attributo in request ha errori --%>
    <spring:hasBindErrors name="update_film_attr">
        <%-- alert errori --%>
        <div class="alert alert-danger " role="alert">
            Attenzione!! Sono presenti errori di validazione
        </div>
    </spring:hasBindErrors>

    <div class="alert alert-danger alert-dismissible fade show ${errorMessage==null?'d-none': ''}" role="alert">
        ${errorMessage}
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>

    <div class='card'>
        <div class='card-header'>
            <h5>Modifica elemento</h5>
        </div>
        <div class='card-body'>

            <h6 class="card-title">I campi con <span class="text-danger">*</span> sono obbligatori</h6>

            <form:form modelAttribute="update_film_attr" method="post" action="saveupdate" novalidate="novalidate">

                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label>Titolo <span class="text-danger">*</span></label>
                        <spring:bind path="titolo">
                            <input type="text" name="titolo" id="titolo"
                                   class="form-control ${status.error ? 'is-invalid' : ''}"
                                   placeholder="Inserire il titolo" value="${update_film_attr.titolo }" required>
                            <spring:bind path="id">
                                <input type="hidden" name="id" id="id"
                                       class="form-control${status.error ? 'is-invalid' : ''}"
                                       value="${update_film_attr.id }" required>
                            </spring:bind>
                        </spring:bind>
                        <form:errors path="titolo" cssClass="error_field"/>
                    </div>

                    <div class="form-group col-md-6">
                        <label>Genere <span class="text-danger">*</span></label>
                        <spring:bind path="genere">
                            <input type="text" name="genere" id="genere"
                                   class="form-control ${status.error ? 'is-invalid' : ''}"
                                   placeholder="Inserire il genere" value="${update_film_attr.genere }" required>
                        </spring:bind>
                        <form:errors path="genere" cssClass="error_field"/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label>Minuti durata <span class="text-danger">*</span></label>
                        <spring:bind path="minutiDurata">
                            <input type="text" class="form-control ${status.error ? 'is-invalid' : ''}"
                                   name="minutiDurata" id="minutiDurata" placeholder="Inserire durata del film"
                                   value="${update_film_attr.minutiDurata }" required>
                        </spring:bind>
                        <form:errors path="minutiDurata" cssClass="error_field"/>
                    </div>

                    <fmt:formatDate pattern='yyyy-MM-dd' var="parsedDate" type='date'
                                    value='${update_film_attr.dataPubblicazione}'/>
                    <div class="form-group col-md-3">
                        <label>Data di Pubblicazione <span class="text-danger">*</span></label>
                        <spring:bind path="dataPubblicazione">
                            <input class="form-control ${status.error ? 'is-invalid' : ''}" id="dataPubblicazione"
                                   type="date" placeholder="dd/MM/yy"
                                   title="formato : gg/mm/aaaa" name="dataPubblicazione" required
                                   value="${parsedDate}">
                        </spring:bind>
                        <form:errors path="dataPubblicazione" cssClass="error_field"/>
                    </div>
                    <br>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="registaSearchInput">Regista:</label>
                            <spring:bind path="regista.id">
                                <input class="form-control ${status.error ? 'is-invalid' : ''}" type="text"
                                       id="registaSearchInput"
                                       name="registaInput"
                                       value="${update_film_attr.regista.nome}${empty update_film_attr.regista.nome?'':' '}${update_film_attr.regista.cognome}">
                            </spring:bind>
                            <input type="hidden" name="regista" id="registaId"
                                   value="${update_film_attr.regista.id }">
                            <form:errors path="regista" cssClass="error_field"/>
                        </div>
                    </div>


                </div>

                <button type="submit" name="submit" value="submit" id="submit" class="btn btn-primary">Conferma</button>

            </form:form>

            <%-- FUNZIONE JQUERY UI PER AUTOCOMPLETE --%>
            <script>
                $("#registaSearchInput").autocomplete({
                    source: function (request, response) {
                        $.ajax({
                            url: "../searchRegistiAjax",
                            datatype: "json",
                            data: {
                                term: request.term,
                            },
                            success: function (data) {
                                response($.map(data, function (item) {
                                    return {
                                        label: item.label,
                                        value: item.value
                                    }
                                }))
                            }
                        })
                    },
                    //quando seleziono la voce nel campo deve valorizzarsi la descrizione
                    focus: function (event, ui) {
                        $("#registaSearchInput").val(ui.item.label)
                        return false
                    },
                    minLength: 2,
                    //quando seleziono la voce nel campo hidden deve valorizzarsi l'id
                    select: function (event, ui) {
                        $('#registaId').val(ui.item.value);
                        //console.log($('#registaId').val())
                        return false;
                    }
                });
            </script>
            <!-- end script autocomplete -->

            <!-- end card-body -->
        </div>
    </div>

    <!-- end container -->
</main>
<jsp:include page="../footer.jsp"/>

</body>
</html>