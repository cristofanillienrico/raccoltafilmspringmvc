package it.prova.raccoltafilmspringmvc.web.controller;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import it.prova.raccoltafilmspringmvc.model.Film;
import it.prova.raccoltafilmspringmvc.model.Regista;
import it.prova.raccoltafilmspringmvc.service.FilmService;
import it.prova.raccoltafilmspringmvc.service.RegistaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.List;

@Controller
@RequestMapping(value = "/film")
public class FilmController {

    @Autowired
    private FilmService filmService;
    @Autowired
    private RegistaService registaService;

    @GetMapping
    public ModelAndView listAllFilms() {
        ModelAndView mv = new ModelAndView();
        List<Film> films = filmService.listAllElements();
        mv.addObject("film_list_attribute", films);
        mv.setViewName("film/list");
        return mv;
    }

    @GetMapping("/insert")
    public String createFilm(Model model) {
        model.addAttribute("insert_film_attr", new Film());
        return "film/insert";
    }

    @PostMapping("/save")
    public String saveFilm(@Valid @ModelAttribute("insert_film_attr") Film film, BindingResult result,
                           RedirectAttributes redirectAttrs) {

// se il regista è valorizzato dobbiamo provare a caricarlo perché
// ci aiuta in pagina. Altrimenti devo fare rejectValue 'a mano' altrimenti
// comunque viene fatta una new durante il binding, anche se arriva stringa vuota
        if (film.getRegista() != null && film.getRegista().getId() != null)
            film.setRegista(registaService.caricaSingoloElemento(film.getRegista().getId()));
        else
            result.rejectValue("regista", "regista.notnull");

        if (result.hasErrors()) {
            return "film/insert";
        }
        filmService.inserisciNuovo(film);

        redirectAttrs.addFlashAttribute("successMessage", "Operazione eseguita correttamente");
        return "redirect:/film";
    }

    @GetMapping("/search")
    public String searchFilm(Model model) {
        model.addAttribute("registi_list_attribute", registaService.listAllElements());
        return "film/search";
    }

    @PostMapping("/list")
    public String listRegisti(Film filmExample, ModelMap model) {
        List<Film> films = filmService.findByExample(filmExample);
        model.addAttribute("film_list_attribute", films);
        return "film/list";
    }

    @GetMapping("/show/{idFilm}")
    public String showFilm(@PathVariable(required = true) Long idFilm, Model model) {
        model.addAttribute("show_film_attr", filmService.caricaSingoloElementoEager(idFilm));
        return "film/show";
    }

    @GetMapping("/delete/{idFilm}")
    public String prepareDeleteFilm(@PathVariable(required = true) Long idFilm, Model model) {
        model.addAttribute("elimina_film_attr", filmService.caricaSingoloElemento(idFilm));
        return "film/delete";
    }

    @PostMapping("/delete/executedelete")
    public String executeDeleteFilm(@Valid @ModelAttribute("idFilm") Long idFilm, RedirectAttributes redirectAttrs) {

        filmService.rimuovi(filmService.caricaSingoloElementoEager(idFilm));

        redirectAttrs.addFlashAttribute("successMessage", "Operazione eseguita correttamente");

        return "redirect:/film";
    }


    @GetMapping("/edit/{idFilm}")
    public String prepareEditFilm(@PathVariable(required = true) Long idFilm, Model model) {
        model.addAttribute("update_film_attr", filmService.caricaSingoloElemento(idFilm));
        return "film/edit";
    }

    @PostMapping("/edit/saveupdate")
    public String saveEditFilm(@Valid @ModelAttribute("update_film_attr") Film film, BindingResult result,
                               RedirectAttributes redirectAttrs) {

        if (film.getRegista() != null && film.getRegista().getId() != null)
            film.setRegista(registaService.caricaSingoloElemento(film.getRegista().getId()));
        else
            result.rejectValue("regista", "regista.notnull");

        if (result.hasErrors()) {
            return "film/edit";
        }

        filmService.aggiorna(film);

        redirectAttrs.addFlashAttribute("successMessage", "Operazione eseguita correttamente");

        return "redirect:/film";
    }

    @GetMapping(value = "/searchRegistiAjax", produces = {MediaType.APPLICATION_JSON_VALUE})
    public @ResponseBody
    String searchRegista(@RequestParam String term) {

        List<Regista> listaRegistaByTerm = registaService.cercaByCognomeENomeILike(term);
        return buildJsonResponse(listaRegistaByTerm);
    }

    private String buildJsonResponse(List<Regista> listaRegisti) {
        JsonArray ja = new JsonArray();

        for (Regista registaItem : listaRegisti) {
            JsonObject jo = new JsonObject();
            jo.addProperty("value", registaItem.getId());
            jo.addProperty("label", registaItem.getNome() + " " + registaItem.getCognome());
            ja.add(jo);
        }

        return new Gson().toJson(ja);
    }


}
