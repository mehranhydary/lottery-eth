import { MongoClient } from 'mongodb'
import { Database } from '../lib/types'

const dbName = `${process.env.DB_NAME}`
const url = `${process.env.DB_URL}`

export const connectDatabase = async (): Promise<Database> => {
    const client = await MongoClient.connect(url, {
        useNewUrlParser: true,
        useUnifiedTopology: true
    })
    const db = client.db(dbName)
    return {
        // users: db.collection('users'),
    }
}