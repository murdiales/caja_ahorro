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

