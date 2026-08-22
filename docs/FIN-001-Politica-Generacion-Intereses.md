# Política de Generación de Intereses

Versión: 1.0
Fecha: 21/08/2026

## Objetivo

Definir las reglas oficiales para la generación de intereses
de la Caja de Ahorro.

## Regla General

Todo depósito realizado durante un mes calendario
comienza a generar intereses en el corte del día 28
del mes siguiente.

## Ejemplos

01/08/2026 → Genera interés el 28/09/2026

15/08/2026 → Genera interés el 28/09/2026

31/08/2026 → Genera interés el 28/09/2026

01/09/2026 → Genera interés el 28/10/2026

## Método de cálculo

Capital Elegible:
Saldo consolidado del período elegible.

Interés:
Capital Elegible × Tasa Vigente

## Configuración

Día de corte:
28

Regla:
Capital del Mes Anterior

Generación automática:
Sí

## Casos de Negocio Aprobados


Caso 1
Depósito: 01/08/2026
Elegibilidad: 28/09/2026

Caso 2
Depósito: 31/08/2026
Elegibilidad: 28/09/2026

Caso 3
Depósito: 01/09/2026
Elegibilidad: 28/10/2026

Caso 4
Depósitos múltiples durante el mismo mes
Se consolidan en el capital elegible del período.

## Capital Elegible

El Capital Elegible no corresponde al saldo actual de la cuenta.

Para cada corte mensual se considerará únicamente el saldo consolidado
del período que haya cumplido la carencia institucional.

Los movimientos realizados durante el mes inmediatamente anterior al corte
no participarán en el cálculo de intereses hasta el siguiente período elegible.

### Ejemplos

Corte: 28/09/2026

Elegible:
Movimientos comprendidos entre 01/08/2026 y 31/08/2026.

No elegible:
Movimientos comprendidos entre 01/09/2026 y 27/09/2026.

---

01/08/2026 + 100
15/08/2026 + 200
31/08/2026 + 300

Capital Elegible:
600

Genera interés:
28/09/2026

---

01/09/2026 + 500

No genera interés:
28/09/2026

Genera interés:
28/10/2026


## Tipo de Interés

La Caja de Ahorro utiliza interés simple.

Los intereses generados no forman parte del capital elegible.

Los intereses acreditados no generan nuevos intereses.

Capital Elegible:

Depósitos
(-) Retiros

No incluye:

Intereses acumulados
Intereses acreditados
Bonificaciones
