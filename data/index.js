const gsjson = require('google-spreadsheet-to-json');
// const admin = require("firebase-admin");
// const serviceAccount = require("./uet-comic-4ca04-firebase-adminsdk-gywgi-15e370b56e.json");
// admin.initializeApp({
//   credential: admin.credential.cert(serviceAccount),
//   databaseURL: "https://uet-comic-4ca04.firebaseio.com"
// });
// const db = admin.firestore();
// const comicCollection = db.collection("comic");
// const chapterCollection = db.collection("chapter");
// const authorCollection = db.collection("author");
// const typeCollection = db.collection("type");

gsjson({
    spreadsheetId: '1uJFd0lZzymdqNJ0yE09D1U7u9bFyE0bn9mH9yJ3jzPg',
    worksheet: ["comic", "chapter", "author", "type"]
})
    .then(function (result) {
        /** create comic collection */
        const comics = result[0];
        // console.log(comics)
        // comics[0].lastUpdate = new Date(Date.UTC(0) + (comics[0].lastUpdate - 2) * 24 * 60 * 60 * 1000);
        // comicCollection.doc(comics[0].id.toString()).set(comics[0], { merge: true });
        comics.forEach(comic => {
            try {
                comic.idTypes = comic.idTypes.split(",");
                comic.idChapters = comic.idChapters.split(",");
                // comic.lastUpdate = new Date(Date.UTC(0) + (comic.lastUpdate - 2) * 24 * 60 * 60 * 1000).toLocaleDateString('vn-VN', { timeZone: 'UTC' });
                comic.lastUpdate = new Date(Date.UTC(0) + (comic.lastUpdate - 2) * 24 * 60 * 60 * 1000);
                // comicCollection.doc(comic.id.toString()).set(comic, { merge: true });
                let splitNames = comic.name.split(/\s+/);
                comic.searchIndexs = [];
                for (let index = 0; index < splitNames.length; index++) {
                    const splitName = splitNames[index];
                    for (let i = 0; i < splitName.length; i++) {
                        let searchIndex = splitName.substring(0, i + 1).toLowerCase();
                        comic.searchIndexs.push(searchIndex);
                        let plusSearchIndex = searchIndex.normalize("NFD")
                            .replace(/[\u0300-\u036f]/g, "")
                            .replace(/đ/g, "d")
                            .replace(/Đ/g, "D")
                        if (searchIndex !== plusSearchIndex) {
                            comic.searchIndexs.push(plusSearchIndex);
                        }
                    }
                }
            } catch (error) {
            }
        });
        console.log(comics)

        /** create chapter collection */
        // const chapters = result[1];
        // chapters.forEach(chapter => {
        //     try {
        //         chapter.images = chapter.images.split(",");
        //         chapter.images.forEach(img => console.log(img));
        //         // chapterCollection.doc(chapter.id.toString()).set(chapter, { merge: true });
        //     } catch (error) {
        //     }
        // });
        // console.log(chapters)

        /** create author collection */
        // const authors = result[2];
        // authors.forEach(author => {
        //     authorCollection.doc(author.id.toString()).set(author, {merge: true});
        // });

        /** create type collection */
        // const types = result[3];
        // types.forEach(type => {
        //     typeCollection.doc(type.id.toString()).set(type, {merge: true});
        // });
    })
    .catch(function (err) {
        console.log(err.message);
        console.log(err.stack);
    });

    // const formatGsDates = (items, dateColumns) => items.map(item => { dateColumns.forEach(col => { if (item[col]) { item[col] = new Date( Date.UTC(0) + (item[col] - 2) * 24 * 60 * 60 * 1000 ).toLocaleDateString('en-US', { timeZone: 'UTC' }) } }) return item })
