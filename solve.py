#!/usr/bin/env python3
"""
Planificador PDDL para Manito - Apilador de bloques
Ejecuta pyperplan para resolver problemas de bloques.
"""

import sys
from pathlib import Path
from pyperplan.planner import search_plan, SEARCHES, HEURISTICS


def solve(domain_file: str, problem_file: str) -> bool:
    """
    Ejecuta pyperplan y muestra el plan.

    Args:
        domain_file: Ruta al archivo domain.pddl
        problem_file: Ruta al archivo problem.pddl

    Returns:
        True si se encontró solución, False en caso contrario
    """
    domain_path = Path(domain_file)
    problem_path = Path(problem_file)

    if not domain_path.exists():
        print(f"Error: {domain_file} no encontrado")
        return False

    if not problem_path.exists():
        print(f"Error: {problem_file} no encontrado")
        return False

    print(f"Resolviendo: {problem_path.name}")
    print(f"Dominio: {domain_path.name}")
    print("-" * 60)

    try:
        # Usar pyperplan: búsqueda A* con heurística blind
        search_algorithm = SEARCHES["astar"]
        heuristic_class = HEURISTICS["blind"]

        plan = search_plan(
            str(domain_path), str(problem_path), search_algorithm, heuristic_class
        )

        if plan is None or len(plan) == 0:
            print("No se encontró solución")
            return False

        # Mostrar plan
        output = f"Plan encontrado ({len(plan)} acciones):\n"
        for i, action in enumerate(plan, 1):
            output += f"{i}. {action}\n"

        print(output)

        # Guardar plan en archivo .soln
        soln_file = problem_path.with_suffix(problem_path.suffix + ".soln")
        with open(soln_file, "w") as f:
            f.write(output)

        print(f"Plan guardado en: {soln_file.name}")
        return True

    except Exception as e:
        print(f"Error: {e}")
        import traceback

        traceback.print_exc()
        return False


def main():
    """Punto de entrada principal."""
    if len(sys.argv) < 2:
        print("Uso: python solve.py <problem.pddl>")
        print("\nEjemplos:")
        print("  python solve.py goal-green-red-blue.pddl")
        print("  python solve.py goal-blue-red-green.pddl")
        sys.exit(1)

    problem_file = sys.argv[1]
    domain_file = "domain.pddl"

    success = solve(domain_file, problem_file)
    sys.exit(0 if success else 1)


if __name__ == "__main__":
    main()
