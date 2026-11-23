# Priorité du ménage — mise à jour familiale

## Mise en route
1. Dans Supabase → **SQL Editor**, exécutez intégralement `schema.sql` (il peut être relancé sans recréer les colonnes). La dernière instruction met tout membre nommé **Julien** en administrateur (`name ILIKE 'julien'`). Si Julien n’existe pas encore, relancez cette instruction après l’avoir ajouté.
2. Hébergez les fichiers de la racine du ZIP sur Netlify Drop ou GitHub Pages. Dans **Réglages**, entrez l’URL du projet Supabase et sa clé publique **anon/publishable**, jamais la clé `service_role`.
3. Au premier lancement, créez le premier profil. Le profil créé en mode local peut être synchronisé quand Supabase sera ensuite configuré. Choisissez un membre à l’écran **Qui êtes-vous ?** ; le choix est mémorisé sur cet appareil.

## Utilisation
- **Membres & dispos** : l’administrateur peut ajouter, modifier, colorer, supprimer les membres, choisir adulte/enfant, attribuer le rôle administrateur et saisir les disponibilités de chacun. Le membre non-administrateur ne voit/modifie que ses propres disponibilités. Sélectionnez des plages en glissant sur la grille lundi–dimanche, de 8 h à 22 h, par demi-heure; les anciennes disponibilités 4 créneaux sont converties automatiquement.
- **Planning** : vue de la semaine pour tout le foyer, avec filtre par membre. Les tâches sont repérées par la couleur de la personne. La proposition évite les chevauchements, répartit les tâches récurrentes sur les jours et ne place une tâche que sur des demi-heures libres contiguës suffisantes. Une tâche « Adultes seulement » ne peut pas être assignée à un enfant; les occurrences impossibles sont signalées.
- **Priorités** : notes individuelles de 0 à 10; le profil courant ne peut pas être changé par les autres membres. L’administrateur dispose du bouton **Changer de personne**.
- **Compte rendu** : conserve le classement, le détail des notes, le responsable, la durée estimée et le type corvée/loisir. Les tâches gardent leur estimation, fréquence, responsable et catégorie.

## À savoir
Le choix de profil et certaines coches sont stockés sur l’appareil. L’application familiale n’utilise pas d’authentification Supabase : le rôle d’administrateur contrôle l’interface locale, **pas** l’API. Les policies anon de `schema.sql` autorisent toujours la lecture et l’écriture complètes, comme dans le schéma existant; toute personne ayant l’URL et la clé anon peut accéder aux données. N’utilisez pas ce modèle pour des données sensibles ou un site public sans renforcer l’authentification et les politiques RLS côté serveur.

Après déploiement, rechargez la PWA. Le cache du service worker est passé à `menage-shell-v11`.

## Fichiers
`index.html`, `schema.sql`, `sw.js`, `manifest.json`, `icon.svg` et ce fichier sont inclus à la racine de l’archive.
