# Migrate Google Contacts labels to FastMail groups

Migrating my contacts from Google Workspace to FastMail, while preserving the contact labels/groups, has been surprisingly difficult.

At first, I tried the automated import tool offered by FastMail. It is designed to retrieve contacts directly from Google, using CardDAV, and import them into FastMail, without any manual export/import. But it didn't work for me. Out of a total of 2 239 contacts, 455 couldn't be imported. The error message looked like this: `Could not fetch contact with UID default/3b6d14c50b666040. Skipping.`. The root cause appears to be the UID starting with `default/`, as the other UIDs were imported correctly.

The other problem was that my contact groups were not found: `Found 0 contact groups containing a total of 2239 contacts.`.

My next attempt was to export my contacts from Google Contacts using the vCard format, and then upload that file to FastMail. This went much better as all the contacts were successfully imported. But the groups were still ignored. This is because Google and FastMail have different ways of representing labels/groups: Google uses vCard categories, while FastMail (and Apple as well) uses vCard groups. Google only knows how to export categories. And FastMail only knows how to import groups. You can read more about it [here](https://github.com/mstilkerich/rcmcarddav/blob/master/doc/GROUPS.md).

I eventually managed to migrate my contacts and keep the labels/groups by following these steps:

1. In Google Contacts, rename all the labels by prefixing them with a unique string, and replacing spaces with hyphens: for example "Best friends" becomes "ZZZ-Best-friends".
2. In Google Contacts, export all contacts as a vCard file.
3. In a text editor, replace all instances of `CATEGORIES:` with `X-FM-ONLINE-OTHER;LABEL=Categories:`. The reason for renaming is that the property `CATEGORIES` is ignored by FastMail, but `X-FM-ONLINE-OTHER` is not. This will allow us import and use the categories in FastMail.
4. In the FastMail web interface, import the modified vCard file.
5. In the FastMail web interface, for each label/group:
    1. Search for the label/group's name followed by a comma: for example `XXX-Best-friends,`. Adding a comma at the end works because the last category exported by Google Contacts is always `myContacts`.
    2. Select all matching contacts.
    3. Click on "Groups" and select "Create group" to add the contacts to a new group: for example "Best friends".

Hopefully, this works for you too, if you ever need this!