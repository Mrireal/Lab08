# Manito - PDDL Blocks World Planner

Planificador PDDL para resolver problemas de apilamiento de bloques usando Manito (robot manipulador).

## Descripción

Este proyecto implementa un dominio PDDL simple (Blocks World) que modela:
- Una pinza que sostiene a lo máximo un cubo
- Cubos sobre la mesa o sobre otro cubo
- Cubos libres o bloqueados por arriba
- Acciones simbólicas: pickup, putdown, stack, unstack

## Estructura del Proyecto

```
.
├── domain.pddl                    # Dominio PDDL con predicados y acciones
├── goal-green-red-blue.pddl      # Problema A: torre green → red → blue
├── goal-blue-red-green.pddl      # Problema B: torre blue → red → green
├── goal-green-red-blue.pddl.soln # Solución A
├── goal-blue-red-green.pddl.soln # Solución B
├── solve.py                       # Script para ejecutar pyperplan
├── pyproject.toml                 # Configuración del proyecto
├── README.md                      # Este archivo
```

## Instalación

### Requisitos
- Python 3.8+
- uv (gestor de paquetes)

### Pasos

```bash
# Instalar dependencias
uv sync

# Crear entorno virtual (si no está creado)
python -m venv .venv
.venv\Scripts\activate  # En Windows
source .venv/bin/activate  # En Linux/Mac

# Instalar dependencias
pip install pyperplan>=2.1
```

## Uso

### Resolver Problema A (green → red → blue)
```bash
python solve.py goal-green-red-blue.pddl
```

Resultado esperado:
1. Tomar red
2. Apilar red sobre blue
3. Tomar green
4. Apilar green sobre red

### Resolver Problema B (blue → red → green)
```bash
python solve.py goal-blue-red-green.pddl
```

Resultado esperado:
1. Tomar red
2. Apilar red sobre green
3. Tomar blue
4. Apilar blue sobre red

## Dominio PDDL

### Predicados

- `ontable(X)` - X está sobre la mesa
- `on(X, Y)` - X está sobre Y (X encima, Y debajo)
- `clear(X)` - X está libre (nada encima)
- `holding(X)` - Garra sostiene X
- `handempty` - Garra está vacía

### Acciones

1. **pickup(X)**: Tomar un bloque de la mesa
   - Pre: clear(X), ontable(X), handempty
   - Eff: holding(X), ¬handempty, ¬ontable(X), ¬clear(X)

2. **putdown(X)**: Soltar un bloque en la mesa
   - Pre: holding(X)
   - Eff: ontable(X), handempty, ¬holding(X), clear(X)

3. **stack(X, Y)**: Apilar X sobre Y
   - Pre: holding(X), clear(Y)
   - Eff: on(X, Y), clear(X), handempty, ¬holding(X), ¬clear(Y)

4. **unstack(X, Y)**: Desapilar X de Y
   - Pre: on(X, Y), clear(X), handempty
   - Eff: holding(X), clear(Y), ¬on(X, Y), ¬clear(X), ¬handempty

## Escena Inicial (siempre igual)

- Tres bloques: blue, red, green
- Todos sobre la mesa y separados
- Todos libres (clear)
- Garra vacía (handempty)

## Planificador Utilizado

Se utiliza **pyperplan** (versión 2.1+) con:
- Algoritmo: A* search
- Heurística: blind (sin heurística)

## Ejemplos de Planes Generados

### Plan A (Meta: green → red → blue)
```
1. (pickup red)
2. (stack red blue)
3. (pickup green)
4. (stack green red)
```

### Plan B (Meta: blue → red → green)
```
1. (pickup red)
2. (stack red green)
3. (pickup blue)
4. (stack blue red)
```

## Autor
Proyecto para USS-ICIFH001 - Inteligencia Artificial
Universidad San Sebastián
Laboratorio 08 - 2026
