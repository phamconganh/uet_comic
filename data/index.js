const gsjson = require('google-spreadsheet-to-json');
const admin = require("firebase-admin");
const serviceAccount = require("./uet-comic-4ca04-firebase-adminsdk-gywgi-15e370b56e.json");
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://uet-comic-4ca04.firebaseio.com"
});
const db = admin.firestore();
// const comicCollection = db.collection("comic");
const chapterCollection = db.collection("chapter");
// const authorCollection = db.collection("author");
// const typeCollection = db.collection("type");

gsjson({
    spreadsheetId: '1uJFd0lZzymdqNJ0yE09D1U7u9bFyE0bn9mH9yJ3jzPg',
    worksheet: ["comic", "chapter", "author", "type"]
})
    .then(function (result) {
        // /** create comic collection */
        // const comics = result[0];
        // comics.forEach(comic => {
        //     try {
        //         comic.idTypes = comic.idTypes.split(",");
        //         comic.idChapters = comic.idChapters.split(",");
        //         comic.lastUpdate = new Date(Date.UTC(0) + (comic.lastUpdate - 2) * 24 * 60 * 60 * 1000);
        //         let splitNames = comic.name.split(/\s+/);
        //         comic.searchIndexs = [];
        //         for (let index = 0; index < splitNames.length; index++) {
        //             const splitName = splitNames[index];
        //             for (let i = 0; i < splitName.length; i++) {
        //                 let searchIndex = splitName.substring(0, i + 1).toLowerCase();
        //                 comic.searchIndexs.push(searchIndex);
        //                 let plusSearchIndex = searchIndex.normalize("NFD")
        //                     .replace(/[\u0300-\u036f]/g, "")
        //                     .replace(/đ/g, "d")
        //                     .replace(/Đ/g, "D")
        //                 if (searchIndex !== plusSearchIndex) {
        //                     comic.searchIndexs.push(plusSearchIndex);
        //                 }
        //             }
        //         }
        //         comicCollection.doc(comic.id.toString()).set(comic, { merge: true });
        //     } catch (error) {
        //     }
        // });

        /** create chapter collection */
        const chapters = result[1];
        chapters.forEach(chapter => {
            try {
                chapter.images = chapter.images.split(",");
                chapter.lastUpdate = new Date(Date.UTC(0) + (chapter.lastUpdate - 2) * 24 * 60 * 60 * 1000);
                chapterCollection.doc(chapter.id.toString()).set(chapter, { merge: true });
            } catch (error) {
            }
        });

        // /** create author collection */
        // const authors = result[2];
        // authors.forEach(author => {
        //     authorCollection.doc(author.id.toString()).set(author, {merge: true});
        // });

        // /** create type collection */
        // const types = result[3];
        // types.forEach(type => {
        //     typeCollection.doc(type.id.toString()).set(type, {merge: true});
        // });
    })
    .catch(function (err) {
        console.log(err.message);
        console.log(err.stack);
    });

// comic.lastUpdate = new Date(Date.UTC(0) + (comic.lastUpdate - 2) * 24 * 60 * 60 * 1000).toLocaleDateString('vn-VN', { timeZone: 'UTC' });
