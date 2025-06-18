# Compilador "Flaite"

Taller de Fundamentos de Ciencias de la Computación

# Integrantes:
- Adrián Elgueta. 21.464.061-9
- Paula Núñez. 21.145.637-K

Lenguaje desarrollado con **Flex**, **Bison** y **C++**

---

## Descripción de la gramática del lenguaje

Este compilador interpreta un lenguaje con una estética informal (o "flaite"), orientado a facilitar el aprendizaje del funcionamiento interno de un compilador: desde el análisis léxico hasta la ejecución de instrucciones.

---

### Palabras clave

| Palabra         | Equivalente tradicional  |
|-----------------|--------------------------|
| `numeta`        | `int` (entero)           |
| `palabrita`     | `string` (cadena texto)  |
| `tiene`         | `=` (asignación)         |
| `suelta_la_voz` | `print` (imprimir)       |
| `sapeate`       | `input` (leer por teclado) |
| `al_toke`       | `while` (bucle)          |
| `la_ura`        | `if` (condicional)       |
| `en_vola`       | `else`                   |

---

## Tipos de datos

- **Enteros (`numeta`)**: valores numéricos como `0`, `123`, `-5`.
- **Texto (`palabrita`)**: cadenas delimitadas por comillas dobles `"Hola mundo"`.

---

## Operadores

| Tipo              | Símbolos soportados  |
|-------------------|-----------------------|
| Aritméticos        | `+`, `-`, `*`, `/`     |
| Comparación        | `==`, `!=`, `<`, `<=`, `>`, `>=` |
| Asignación         | `tiene` (equivalente a `=`) |
| Agrupación lógica  | `()`                   |

---

## Estructura del Compilador

El compilador flaite sigue una estructura clásica:

### 1. Análisis Léxico

Se encarga de identificar **tokens** como:
- Palabras clave
- Identificadores
- Literales numéricos y de texto
- Operadores y símbolos especiales

Ejemplo:
```txt
numeta edad;
edad tiene 5;
```
Tokens generados:  
`[KEYWORD:numeta, ID:edad, SEMICOLON, ID:edad, ASSIGN, NUM:5, SEMICOLON]`

---

### 2. Análisis Sintáctico

Utiliza **Bison** para validar que la estructura de tokens forma sentencias válidas y construir un **Árbol de Sintaxis Abstracta (AST)**.

Errores como:
- Falta de punto y coma
- Uso incorrecto de paréntesis
- Asignaciones sin declarar variables  
...son detectados aquí.

---

### 3. Análisis Semántico

Valida que:
- Las variables hayan sido **declaradas antes de usarse**
- El tipo de dato sea el correcto (`numeta` ≠ `palabrita`)
- La lógica del código tenga coherencia

---

## Características del lenguaje

- Declaración y uso de enteros (`numeta`)
- Declaración y uso de strings (`palabrita`)
- Impresión de variables y literales (`suelta_la_voz`)
- Entrada por teclado (`sapeate`)
- Condicionales `if`/`else` (`la_ura` / `en_vola`)
- Bucle `while` (`al_toke`)
- Operaciones aritméticas y comparativas

---

## Ejemplo de programa válido

```txt
numeta contador;
contador tiene 0;

al_toke (contador < 3) {
  suelta_la_voz(contador);
  contador tiene contador + 1;
}

palabrita saludo;
saludo tiene "Hola flaite!";
suelta_la_voz(saludo);
```

---

## Cómo compilar y ejecutar

### Requisitos

- **g++** con soporte C++17 (ej: MinGW en Windows)
- **Flex** y **Bison**

### Compilación

```bash
build.bat
```

Se ejecuta con Ctrl+Mayús+B.
Este script genera el ejecutable `compilador.exe`.

### Ejecución

```bash
compilador < entrada.txt
```

### O también

```bash
compilador.exe, luego "Ctrl + Z"
```

---

## Observaciones

- Las cadenas de texto deben ir entre comillas dobles: `"Hola mundo"`
- No se permite usar variables sin declararlas previamente
- No se puede reasignar un string con un valor numérico (ni viceversa)

---

## Comentarios finales

Este proyecto permite entender cómo funcionan los compiladores a bajo nivel. Integra técnicas reales como:
- Manejo de tokens
- Construcción de AST
- Evaluación de expresiones

---
## Documentación

- 📄 [Ver informe del compilador](./informe_compilador.pdf)