package it.prova.raccoltafilmspringmvc.repository.film;


import it.prova.raccoltafilmspringmvc.model.Film;

import java.util.List;

public interface CustomFilmRepository {

	List<Film> findByExample(Film example);

}
