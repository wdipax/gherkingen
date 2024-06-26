package generator

import (
	"bytes"
	"fmt"
	"strconv"
	"strings"
	"text/template"
	"unicode"

	"github.com/hedhyw/gherkingen/v4/internal/model"

	"github.com/iancoleman/strcase"
)

// generateRaw generates a raw outpur using an input data and a template.
func generateRaw(
	tmplSource []byte,
	tmplData *model.TemplateData,
) (out []byte, err error) {
	var buf bytes.Buffer

	tmpl, err := template.New("template").
		Funcs(template.FuncMap{
			"upperAlias":   aliasPreparer(strcase.ToCamel),
			"lowerAlias":   aliasPreparer(strcase.ToLowerCamel),
			"trimSpace":    strings.TrimSpace,
			"prepareGoStr": prepareGoStr,
			"withFinalDot": withFinalDot,
		}).
		Parse(string(tmplSource))
	if err != nil {
		return nil, fmt.Errorf("parsing template: %w", err)
	}

	if err = tmpl.Execute(&buf, tmplData); err != nil {
		return nil, fmt.Errorf("executing template: %w", err)
	}

	return buf.Bytes(), nil
}

func withFinalDot(text string) string {
	if text == "" {
		return ""
	}

	if strings.HasSuffix(text, ".") {
		return text
	}

	textRunes := []rune(text)
	var lastRune rune
	var lastRuneIndex int

	for i := len(textRunes) - 1; i >= 0; i-- {
		if !unicode.IsSpace(textRunes[i]) {
			lastRune = textRunes[i]
			lastRuneIndex = i

			break
		}
	}

	if lastRune == 0 {
		return text
	}

	switch {
	case
		lastRune == '.',
		lastRune == ',',
		lastRune == '!',
		lastRune == '?':

		return text
	case
		unicode.IsLetter(lastRune),
		unicode.IsDigit(lastRune),
		unicode.IsPunct(lastRune),
		unicode.IsSymbol(lastRune):

		return string(textRunes[:lastRuneIndex+1]) +
			"." +
			string(textRunes[lastRuneIndex+1:])
	default:
		return text
	}
}

func aliasPreparer(postFormatter func(string) string) func(string) string {
	var i int

	return func(text string) string {
		alias := make([]rune, 0, len(text))

		for _, r := range text {
			switch {
			case
				unicode.IsDigit(r) && len(alias) != 0,
				unicode.IsLetter(r):

				alias = append(alias, r)
			case unicode.IsSpace(r), r == '_':
				alias = append(alias, '_')
			}
		}

		if len(alias) == 0 {
			i++

			return postFormatter("var" + strconv.Itoa(i))
		}

		return postFormatter(string(alias))
	}
}

func prepareGoStr(text string) string {
	text = strings.ReplaceAll(text, `"`, `\"`)

	return text
}
