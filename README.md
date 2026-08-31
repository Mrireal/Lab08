# Israel González - Matias Carcamo

# Manito - Planificador de Bloques PDDL

Planificador PDDL para resolver problemas de apilamiento de bloques usando Manito (robot manipulador).

## Descripción

Este proyecto implementa un dominio PDDL simple (Blocks World / Mundo de Bloques) que modela:

- Una garra/pinza que sostiene a lo máximo un bloque
- Bloques sobre la mesa o sobre otro bloque
- Bloques libres (sin nada encima) o bloqueados
- Acciones simbólicas: tomar, soltar, apilar y desapilar

## Estructura del Proyecto

```
.
├── domain.pddl                    # Dominio PDDL con predicados y acciones
├── goal-green-red-blue.pddl      # Meta A: torre verde → rojo → azul
├── goal-blue-red-green.pddl      # Meta B: torre azul → rojo → verde
├── goal-green-red-blue.pddl.soln # Solución Meta A
├── goal-blue-red-green.pddl.soln # Solución Meta B
├── solve.py                       # Script para ejecutar pyperplan
├── pyproject.toml                 # Configuración del proyecto
├── README.md                      # Este archivo
```

## Instalación

### Requisitos

- Python 3.8+
- uv (gestor de paquetes) - opcional

### Pasos

#### Opción 1: Con entorno virtual manual

```bash
# Crear entorno virtual
python -m venv .venv

# Activar entorno
.venv\Scripts\activate  # En Windows
source .venv/bin/activate  # En Linux/Mac

# Instalar dependencia
pip install pyperplan>=2.1
```

#### Opción 2: Con uv

```bash
uv sync
```

## Uso

### Resolver Meta A (verde → rojo → azul)

```bash
python solve.py goal-green-red-blue.pddl
```

**Resultado esperado (4 acciones)**:

1. Tomar rojo
2. Apilar rojo sobre azul
3. Tomar verde
4. Apilar verde sobre rojo

**Torre final**: verde encima de rojo encima de azul

### Resolver Meta B (azul → rojo → verde)

```bash
python solve.py goal-blue-red-green.pddl
```

**Resultado esperado (4 acciones)**:

1. Tomar rojo
2. Apilar rojo sobre verde
3. Tomar azul
4. Apilar azul sobre rojo

**Torre final**: azul encima de rojo encima de verde

## Dominio PDDL

### Predicados

| Predicado        | Significado                         |
| ---------------- | ----------------------------------- |
| `sobre_mesa(X)`  | X está sobre la mesa                |
| `sobre(X, Y)`    | X está sobre Y (X encima, Y debajo) |
| `libre(X)`       | X está libre (nada encima)          |
| `sosteniendo(X)` | Garra sostiene X                    |
| `mano_vacia`     | Garra está vacía                    |

### Acciones

#### 1. **tomar(X)** - Tomar un bloque de la mesa

```pddl
Precondiciones:
  - libre(X)
  - sobre_mesa(X)
  - mano_vacia

Efectos:
  - sosteniendo(X)
  - ¬mano_vacia
  - ¬sobre_mesa(X)
  - ¬libre(X)
```

#### 2. **soltar(X)** - Soltar un bloque en la mesa

```pddl
Precondiciones:
  - sosteniendo(X)

Efectos:
  - sobre_mesa(X)
  - mano_vacia
  - ¬sosteniendo(X)
  - libre(X)
```

#### 3. **apilar(X, Y)** - Apilar X sobre Y

```pddl
Precondiciones:
  - sosteniendo(X)
  - libre(Y)

Efectos:
  - sobre(X, Y)
  - libre(X)
  - mano_vacia
  - ¬sosteniendo(X)
  - ¬libre(Y)
```

#### 4. **desapilar(X, Y)** - Desapilar X de Y

```pddl
Precondiciones:
  - sobre(X, Y)
  - libre(X)
  - mano_vacia

Efectos:
  - sosteniendo(X)
  - libre(Y)
  - ¬sobre(X, Y)
  - ¬libre(X)
  - ¬mano_vacia
```

## Escena Inicial (siempre igual)

- **Tres bloques**: azul, rojo, verde
- **Posición inicial**: todos sobre la mesa y separados
- **Estado**: todos libres (sin nada encima)
- **Garra**: vacía (mano_vacia)

```
azul    rojo    verde
 □       □       □
━━━━━━━━━━━━━━━━━━━━━
        mesa
```

## Planificador Utilizado

Se utiliza **pyperplan** (versión 2.1+) con:

- **Algoritmo de búsqueda**: A\* (A-Star)
- **Heurística**: blind (sin heurística estimada)

## Planes Generados

### Plan Meta A (verde → rojo → azul)

```
1. (tomar rojo)
2. (apilar rojo azul)
3. (tomar verde)
4. (apilar verde rojo)
```

**Torre resultante**:

```
  verde
  ─────
  rojo
  ─────
  azul
━━━━━━━━━
   mesa
```

### Plan Meta B (azul → rojo → verde)

```
1. (tomar rojo)
2. (apilar rojo verde)
3. (tomar azul)
4. (apilar azul rojo)
```

**Torre resultante**:

```
  azul
  ─────
  rojo
  ─────
  verde
━━━━━━━━━
   mesa
```

## Archivos de Solución (.soln)

Los archivos `.soln` contienen:

- Número total de acciones
- Lista detallada de cada acción con:
  - Precondiciones (PRE)
  - Adiciones (ADD)
  - Eliminaciones (DEL)

## Detalles Técnicos

### Tipos PDDL

- `bloque` - Tipo para los objetos (azul, rojo, verde)

### Requisitos

- `:strips` - Acciones básicas sin estructura condicional
- `:typing` - Soporte para tipos

### No se modela

- Coordenadas ni posiciones exactas
- Cinemática ni trayectorias del robot
- Detección de colisiones
- Sistema de visión del robot
- Ejecución en robot físico

## Ejecución y Validación

Para validar que los planes son correctos:

```bash
# Resolver ambos problemas
python solve.py goal-green-red-blue.pddl
python solve.py goal-blue-red-green.pddl

# Verificar que se crearon los archivos .soln
ls *.soln
```

## Autor y Contexto

**Proyecto para**: USS-ICIFH001 - Inteligencia Artificial  
**Universidad**: Universidad San Sebastián  
**Laboratorio**: 08 - PDDL para Manito  
**Año**: 2026
