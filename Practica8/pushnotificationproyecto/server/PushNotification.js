const admin = require('firebase-admin');

// Carga del archivo de credenciales del service account
const serviceAccount = require('./serviceAccountKey.json');

// Inicializar el SDK de Firebase Admin
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
});

// TODO: pega aquí el token FCM que te dio la app Flutter
const deviceToken = 'c5_dNF-4R0KkH6K4OPCrn_:APA91bEpSoT5vGWxwFPuty0HDsIa_8AjMW92XGKRXLs5i768XeBGI-9n7Mf-WesNEym5blxGyFIQE0X7NXaizezFx5ki6R2lPite1iUHtX3TQ7rloLMkOZM';

async function sendPush() {

    const message = {
        token: deviceToken,
        notification: {
            title: 'Prueba de que si llegan las notificaciones',
            body: 'Jair Antonio Martinez Valladares - 10D - Prueba',
        },
        data: {
            origen: 'node-demo',
            tipo: 'prueba',
        },
    };
    try {
        const response = await admin.messaging().send(message);
        console.log('✅ Mensaje enviado correctamente:', response);
    } catch (error) {
        console.error('❌ Error al enviar mensaje:', error);
    }
}

sendPush();