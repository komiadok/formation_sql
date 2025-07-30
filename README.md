# 🚀 Formation SQL avec la base de données Adventure Works

## 📖 Description du projet

Ce projet a pour objectif de vous accompagner dans l'apprentissage et la montée en compétences en SQL à travers la manipulation de la célèbre base de données **Adventure Works**. Cette base de données, fournie par Microsoft, simule une entreprise de fabrication et de vente de vélos et accessoires, offrant ainsi un contexte riche pour apprendre les requêtes SQL dans un cadre réaliste.

Au cours de cette formation, vous allez :  
- Découvrir la structure d’une base de données relationnelle complète (tables, clés primaires/étrangères).  
- Apprendre à écrire des requêtes SQL efficaces (SELECT, JOIN, WHERE, GROUP BY, HAVING, etc.).  
- Manipuler des données avec des opérations CRUD (Create, Read, Update, Delete).  
- Explorer des concepts avancés comme les sous-requêtes, les vues, les fonctions d’agrégation et analytiques.  
- Réaliser des cas pratiques et exercices pour renforcer vos compétences.

---

## 🎯 Objectifs pédagogiques

- Comprendre les concepts fondamentaux du langage SQL.  
- Savoir interroger une base de données relationnelle complexe.  
- Maîtriser les différentes jointures et filtrages.  
- Apprendre à structurer et optimiser ses requêtes SQL.  
- Se préparer à des projets réels de gestion et d’analyse de données.

---

## ⚙️ Prérequis

Avant de commencer cette formation, vous devez avoir :

- Des notions de base en bases de données relationnelles (idéalement).  
- Un ordinateur avec un système d’exploitation Windows, macOS ou Linux.  
- Les outils suivants installés :

### 🛠️ Outils à installer

1. **SQL Server Management Studio (SSMS)** (pour Windows) ou un outil équivalent de gestion SQL (Azure Data Studio, DBeaver, etc.)  
   - [Télécharger SSMS](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms)  
   - Ou [Azure Data Studio](https://learn.microsoft.com/en-us/sql/azure-data-studio/download-azure-data-studio)

2. **SQL Server Express Edition** (gratuit) ou une instance SQL Server accessible  
   - [Télécharger SQL Server Express](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)

3. **Base de données Adventure Works**  
   - Télécharger le fichier Adventure Works au format `.bak` :  
     [Adventure Works sur GitHub Microsoft](https://learn.microsoft.com/fr-fr/sql/samples/adventureworks-install-configure?view=sql-server-ver17&tabs=ssms)  
   - Instructions pour restaurer la base dans votre instance SQL Server seront fournies.

---

## 🛠️ Installation et configuration

1. Installer SQL Server Express (ou disposer d’une instance SQL Server).  
2. Installer SQL Server Management Studio (ou un outil SQL de votre choix).  
3. Télécharger le fichier Adventure Works (`AdventureWorks2022.bak` par exemple).  
4. Restaurer la base Adventure Works sur votre serveur SQL :  
   - Ouvrez SSMS.  
   - Clic droit sur **Bases de données** > **Restaurer la base de données...**  
   - Sélectionnez le fichier `.bak`.  
   - Suivez l’assistant pour restaurer la base.  
5. Vérifier que la base `AdventureWorks2022` est accessible et fonctionnelle.

---

## 📂 Organisation du projet


- `/requetes` : dossiers contenant les requêtes SQL.  
- `README.md` : ce fichier.


