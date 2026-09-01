# Manito - Planificador de Bloques PDDL

## Instalacion

Ubicarse en la carpeta `Lab08` antes de ejecutar los comandos.

### Opcion 1: con uv

Instalar `uv` si aun no esta instalado:

```powershell
pip install uv
```

Luego instalar las dependencias del proyecto:

```powershell
uv sync
```

### Opcion 2: con pip

```powershell
python -m pip install "pyperplan>=2.1"
```

## Como resolver las metas

El archivo `domain.pddl` contiene las reglas del mundo y cada archivo `goal-*.pddl` define una meta. Al ejecutar el script, se crea o actualiza automaticamente un archivo `.soln` con el plan encontrado.

### Meta A: verde sobre rojo sobre azul

```powershell
python solve.py goal-green-red-blue.pddl
```

Plan esperado:

```text
1. tomar rojo
2. apilar rojo azul
3. tomar verde
4. apilar verde rojo
```

### Meta B: azul sobre rojo sobre verde

```powershell
python solve.py goal-blue-red-green.pddl
```

Plan esperado:

```text
1. tomar rojo
2. apilar rojo verde
3. tomar azul
4. apilar azul rojo
```

## Dominio PDDL

### Predicados

| Predicado | Significado |
| --- | --- |
| `sobre_mesa(X)` | X esta sobre la mesa |
| `sobre(X, Y)` | X esta sobre Y |
| `libre(X)` | No hay bloques encima de X |
| `sosteniendo(X)` | La garra sostiene X |
| `mano_vacia` | La garra esta vacia |

### Acciones

| Accion | Precondiciones | Efectos principales |
| --- | --- | --- |
| `tomar(X)` | X libre, sobre la mesa y mano vacia | La garra sostiene X |
| `soltar(X)` | La garra sostiene X | X queda sobre la mesa y libre |
| `apilar(X, Y)` | La garra sostiene X e Y esta libre | X queda sobre Y |
| `desapilar(X, Y)` | X esta sobre Y, X libre y mano vacia | La garra sostiene X |

## Escena inicial

- Tres bloques: azul, rojo y verde.
- Todos comienzan separados sobre la mesa y libres.
- La garra comienza con la mano vacia.

```text
azul    rojo    verde
 []      []      []
-------------------
        mesa
```

## Como pensamos el problema

Modelamos solo los cambios relevantes para construir una torre: que bloque esta sobre la mesa, sobre otro bloque, libre o sostenido por la garra. No modelamos el movimiento fisico de la garra, coordenadas, trayectorias, colisiones ni vision del robot. La accion `apilar`, por ejemplo, representa la manipulacion completa de dejar un bloque sobre otro.

Esta abstraccion permite que el planificador busque una secuencia valida de acciones sin necesitar simular un robot real.

## Detalles Técnicos

- `bloque` es el tipo de los objetos azul, rojo y verde.
- `:strips` permite definir acciones con precondiciones y efectos.
- `:typing` permite asignar tipos a objetos y parametros.

## Integrantes

- Israel Gonzalez
- Matias Carcamo
- Docente: Cristhian Aguilera, asignatura de Inteligencia Artificial.
