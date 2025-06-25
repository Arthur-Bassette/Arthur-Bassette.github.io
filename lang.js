function getPreferredLang() {
    return localStorage.getItem('preferredLang') || 'en';
}

function applyLangOnLoad() {
    var lang = getPreferredLang();
    setLang(lang);
}

function setLang(lang) {
    var i, el, value;
    var elements = document.querySelectorAll('[data-lang-en]');
    for (i = 0; i < elements.length; i++) {
        el = elements[i];
        value = el.getAttribute('data-lang-' + lang);
        el.textContent = value ? value : el.getAttribute('data-lang-en');
    }

    var langContents = document.querySelectorAll('.lang-content');
    for (i = 0; i < langContents.length; i++) {
        el = langContents[i];
        if (el.getAttribute('data-lang-id') === lang) {
            el.className = 'lang-content active';
        } else {
            el.className = 'lang-content';
        }
    }

    localStorage.setItem('preferredLang', lang);
}

window.onload = applyLangOnLoad;
