package it.prova.raccoltafilmspringmvc.repository.film;

import it.prova.raccoltafilmspringmvc.model.Film;
import org.apache.commons.lang3.StringUtils;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class CustomFilmRepositoryImpl implements CustomFilmRepository {

	@PersistenceContext
	private EntityManager entityManager;

	@Override
	public List<Film> findByExample(Film example) {
		Map<String, Object> paramaterMap = new HashMap<String, Object>();
		List<String> whereClauses = new ArrayList<String>();

		StringBuilder queryBuilder = new StringBuilder("select f from Film f where f.id = f.id ");

		if (StringUtils.isNotEmpty(example.getTitolo())) {
			whereClauses.add(" f.titolo  like :titolo ");
			paramaterMap.put("titolo", "%" + example.getTitolo() + "%");
		}
		if (StringUtils.isNotEmpty(example.getGenere())) {
			whereClauses.add(" f.genere like :genere ");
			paramaterMap.put("genere", "%" + example.getGenere() + "%");
		}
		if (example.getMinutiDurata() != null && example.getMinutiDurata() > 0) {
			whereClauses.add(" f.minutiDurata >= :minutiDurata ");
			paramaterMap.put("minutiDurata", example.getMinutiDurata());
		}
		if (example.getRegista() != null && example.getRegista().getId()!=null) {
			whereClauses.add(" f.regista =:regista ");
			paramaterMap.put("regista", example.getRegista());
		}
		if (example.getDataPubblicazione() != null) {
			whereClauses.add("f.dataPubblicazione >= :dataPubblicazione ");
			paramaterMap.put("dataPubblicazione", example.getDataPubblicazione());
		}

		queryBuilder.append(!whereClauses.isEmpty() ? " and " : "");
		queryBuilder.append(StringUtils.join(whereClauses, " and "));
		TypedQuery<Film> typedQuery = entityManager.createQuery(queryBuilder.toString(), Film.class);

		for (String key : paramaterMap.keySet()) {
			typedQuery.setParameter(key, paramaterMap.get(key));
		}

		return typedQuery.getResultList();
	}

}
