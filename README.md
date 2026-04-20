# 📱 CivilCalc – MVP (Ensayo Cono y Arena)

## 👥 Equipo

* Kevin – Backend Lead 💻
* Pipe – Frontend 🎨
* Sebas – QA / Soporte 🧪

---

## 🧠 Descripción del proyecto

**CivilCalc** es una aplicación móvil diseñada para laboratoristas de ingeniería civil que trabajan en campo.

El objetivo es digitalizar el proceso del **ensayo de cono y arena**, eliminando el uso de papel, reduciendo errores y mejorando la trazabilidad de los datos.

---

## 🚧 Problema

Actualmente, el ensayo se realiza manualmente:

* Uso de formatos físicos
* Cálculos hechos a mano
* Pérdida de información
* Errores humanos frecuentes

---

## 🎯 Solución

CivilCalc permite:

* Ingreso guiado de datos
* Cálculos automáticos basados en flujo real de planta
* Validaciones inteligentes
* Preparación para generación de reportes PDF
* Funcionamiento offline

---

## 🧪 Flujo del ensayo (real de campo)

1. Se pesa el cono completo → **Peso inicial**
2. Se extrae el material del suelo → **Peso húmedo**
3. Se realiza el llenado con arena → **Peso final**
4. Se obtiene la humedad con Speedy → **Humedad (%)**

---

## 📥 Datos de entrada (usuario)

* Peso frasco + arena inicial
* Peso frasco + arena restante
* Peso material extraído húmedo
* Humedad (%)

---

## ⚙️ Datos configurables (admin)

* Constante del cono
* Densidad de la arena

---

## 🧮 Cálculos implementados

```text
Peso arena total = inicial - final
Arena en el hueco = arena total - constante cono
Volumen = arena hueco / densidad arena
Peso seco = peso húmedo / (1 + humedad)
Densidad = peso seco / volumen
```

✔ Incluye validaciones
✔ Incluye redondeo a 3 decimales

---

## 🧱 Arquitectura

Se implementa **Clean Architecture**:

```text
lib/
├── core/
│   └── utils/
│
├── features/
│   └── cono_arena/
│       ├── data/
│       ├── domain/
│       │   ├── entities/
│       │   └── usecases/
│       └── presentation/
```

---

## 🧑‍💻 Tecnologías

* Flutter
* Dart
* Arquitectura limpia (Clean Architecture)
* Desarrollo offline-first

---

## 🚀 Cómo ejecutar el proyecto

1. Clonar el repositorio
2. Abrir en VS Code
3. Ejecutar:

```bash
flutter pub get
flutter run
```

4. Seleccionar navegador (Chrome recomendado)

---

## 🔥 Estado actual del MVP

✔ Arquitectura base
✔ Lógica del ensayo implementada
✔ Validaciones
✔ UI básica funcional

---

## 📌 Próximos pasos

* Mejorar UI/UX
* Guardado local de ensayos
* Generación de PDF
* Configuración editable (constantes)
* Exportación de datos

---

## 💡 Notas importantes

Este proyecto está basado en un **flujo real de laboratorio**, no en teoría genérica, lo que lo hace más preciso y aplicable en campo.

---

## ❤️ Filosofía del proyecto

> “Menos papel, más precisión, mejor ingeniería.”
