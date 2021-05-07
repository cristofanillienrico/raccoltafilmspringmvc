<!doctype html>
<%@page import="java.text.SimpleDateFormat" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<html lang="it">
<head>
    <jsp:include page="../header.jsp"/>
    <title>Elimina elemento</title>

    <!-- style per le pagine diverse dalla index -->
    <link href="${pageContext.request.contextPath }/assets/css/global.css" rel="stylesheet">

</head>
<body>
<jsp:include page="../navbar.jsp"/>

<main role="main" class="container">


    <div class='card'>
        <div class='card-header'>
            Visualizza dettaglio del film da eliminare
        </div>

        <div class='card-body'>
            <dl class="row">
                <dt class="col-sm-3 text-right">Titolo</dt>
                <dd class="col-sm-9">${elimina_film_attr.titolo}</dd>
            </dl>

            <dl class="row">
                <dt class="col-sm-3 text-right">Genere:</dt>
                <dd class="col-sm-9">${elimina_film_attr.genere}</dd>
            </dl>

            <dl class="row">
                <dt class="col-sm-3 text-right">Minuti durata:</dt>
                <dd class="col-sm-9">${elimina_film_attr.minutiDurata}</dd>
            </dl>

            <dl class="row">
                <dt class="col-sm-3 text-right">Data di Pubblicazione:</dt>
                <dd class="col-sm-9"><fmt:formatDate pattern="dd/MM/yyyy"
                                                     value="${elimina_film_attr.dataPubblicazione}"/></dd>
            </dl>


            <!-- info oggetto collegato -->
            <p>
                <a class="btn btn-primary btn-sm" data-toggle="collapse" href="#collapseExample" role="button"
                   aria-expanded="false" aria-controls="collapseExample">
                    Info Regista
                </a>
            </p>
            <div class="collapse" id="collapseExample">
                <div class="card card-body">
                    <dl class="row">
                        <dt class="col-sm-3 text-right">Codice:</dt>
                        <dd class="col-sm-9">${elimina_film_attr.regista.nome}</dd>
                    </dl>
                    <dl class="row">
                        <dt class="col-sm-3 text-right">Descrizione:</dt>
                        <dd class="col-sm-9">${elimina_film_attr.regista.cognome}</dd>
                    </dl>
                    <dl class="row">
                        <dt class="col-sm-3 text-right">Ubicazione:</dt>
                        <dd class="col-sm-9">${elimina_film_attr.regista.nickName}</dd>
                    </dl>
                    <dl class="row">
                        <dt class="col-sm-3 text-right">Ubicazione:</dt>
                        <dd class="col-sm-9">${elimina_film_attr.regista.dataDiNascita}</dd>
                    </dl>
                    <dl class="row">
                        <dt class="col-sm-3 text-right">Ubicazione:</dt>
                        <dd class="col-sm-9">${elimina_film_attr.regista.sesso}</dd>
                    </dl>
                </div>
            </div>
            <!-- end info Regista -->

        </div>

        <div class='card-footer'>

            <form action="executedelete" method="post">
                <a href="${pageContext.request.contextPath }/film/" class='btn btn-outline-secondary'
                   style='width:80px'>
                    <i class='fa fa-chevron-left'></i> Back
                </a>

                <input type="hidden" name="idFilm" value="${elimina_film_attr.id }">
                <button type="submit" class='btn btn-outline-secondary' style='color: black;background-color: red'>
                    Elimina
                </button>

            </form>


        </div>


    </div>


    <!-- end main container -->
</main>
<jsp:include page="../footer.jsp"/>

</body>
</html>