<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller {
    public function register( Request $request ) {
        $request->validate( [
            'name' => 'required',
            'email' => 'required|email',
            'password' => 'required'
        ] );

        $user = User::create( [
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make( $request->password )
        ] );

        return response()->json( [ 'message' => 'Registered successfully', 'user' => $user ], 201 );
    }

    public function login( Request $request ) {
        $request->validate( [
            'email' => 'required|email',
            'password' => 'required'
        ] );

        $user = User::where( 'email', $request->email )->first();

        if ( !$user || !Hash::check( $request->password, $user->password ) ) {
            return response()->json( [ 'message' => 'Invalid credentials' ], 401 );
        }

        $token = $user->createToken( 'auth_token' )->plainTextToken;

        return response()->json( [ 'message' => 'Logged in successfully', 'user' => $user, 'token' => $token ], 200 );
    }

    public function logout( Request $request ) {
        $request->user()->currentAccessToken()->delete();

        return response()->json( [ 'message' => 'Logged out successfully' ], 200 );
    }
}
