import React, { useState } from 'react';
import { Heart, Home, Lock, RefreshCw, Settings, Trophy, Zap, LogOut, User } from 'lucide-react';

const PROFILES = {
  ALISHKA: {
    name: 'АЛИШКА',
    pin: '0609',
    bgGradient: 'from-purple-700 via-purple-900 to-black',
    accentColor: 'text-amber-500',
    borderColor: 'border-amber-500',
    avatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80',
    wins: 15,
    rating: 55,
    duels: 40,
  },
  NIGISHKA: {
    name: 'НИГИШКА',
    pin: '0504',
    bgGradient: 'from-orange-600 via-red-900 to-black',
    accentColor: 'text-purple-300',
    borderColor: 'border-purple-300',
    avatar: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=300&q=80',
    wins: 15,
    rating: 55,
    duels: 40,
  }
};

export default function App() {
  const [screen, setScreen] = useState('SPLASH'); // SPLASH, LOGIN, PUSH, MAIN, PROFILE
  const [pin, setPin] = useState('');
  const [user, setUser] = useState(PROFILES.ALISHKA);

  const handlePinInput = (num) => {
    if (num === '<') {
      setPin(prev => prev.slice(0, -1));
      return;
    }
    if (pin.length < 4) {
      const newPin = pin + num;
      setPin(newPin);
      if (newPin === PROFILES.ALISHKA.pin) {
        setUser(PROFILES.ALISHKA);
        setTimeout(() => { setScreen('PUSH'); setPin(''); }, 200);
      } else if (newPin === PROFILES.NIGISHKA.pin) {
        setUser(PROFILES.NIGISHKA);
        setTimeout(() => { setScreen('PUSH'); setPin(''); }, 200);
      }
    }
  };

  return (
    <div className="flex justify-center items-center min-h-screen bg-neutral-950 p-0 sm:p-4">
      <div className="w-full max-w-md h-screen sm:h-[844px] bg-neutral-900 rounded-none sm:rounded-[40px] overflow-hidden relative flex flex-col justify-between shadow-2xl border-0 sm:border-8 border-neutral-800">
        
        {/* Экран 1: SPLASH SCREEN */}
        {screen === 'SPLASH' && (
          <div className="h-full bg-radial from-amber-400 via-amber-500 to-amber-700 p-6 flex flex-col justify-between items-center text-center">
            <div className="w-full velvet-pillow p-8 mt-12">
              <h1 className="text-4xl font-black text-white tracking-widest">G BOX</h1>
            </div>
            
            <div className="velvet-pillow p-5 rounded-full">
              <Home className="w-8 h-8 text-white" />
            </div>

            <div className="w-full velvet-pillow p-6">
              <h2 className="text-lg font-bold text-white tracking-wider">АЛИШКА ★ НИГИШКА</h2>
              <p className="text-xs text-amber-200 mt-1 font-medium tracking-widest">СЕМЬЯ ДОРОЖЕ ВСЕГО</p>
            </div>

            <button 
              onClick={() => setScreen('LOGIN')} 
              className="w-full velvet-pillow p-5 mb-8 flex justify-center items-center gap-3 cursor-pointer"
            >
              <Zap className="w-5 h-5 text-amber-400" />
              <span className="font-bold text-white tracking-wider">TAP TO START</span>
            </button>
          </div>
        )}

        {/* Экран 2: LOGIN SCREEN (PIN) */}
        {screen === 'LOGIN' && (
          <div className="h-full bg-gradient-to-b from-amber-400 to-amber-600 p-6 flex flex-col justify-between items-center">
            <div className="w-full velvet-pillow p-6 text-center mt-6">
              <h1 className="text-2xl font-black text-white">G BOX</h1>
              <p className="text-sm font-semibold text-amber-200 mt-1">ВВЕДИ PIN</p>
            </div>

            {/* PIN Индикаторы */}
            <div className="flex gap-4 my-4">
              {[0, 1, 2, 3].map((idx) => (
                <div key={idx} className="w-12 h-12 velvet-pillow rounded-full flex items-center justify-center">
                  {pin.length > idx && <div className="w-3.5 h-3.5 bg-white rounded-full"></div>}
                </div>
              ))}
            </div>

            {/* Клавиатура */}
            <div className="grid grid-cols-3 gap-4 w-full mb-6">
              {['1','2','3','4','5','6','7','8','9','','0','<'].map((item, idx) => (
                item !== '' ? (
                  <button 
                    key={idx} 
                    onClick={() => handlePinInput(item)}
                    className="velvet-pillow py-4 text-xl font-bold text-white flex justify-center items-center cursor-pointer"
                  >
                    {item === '<' ? '←' : item}
                  </button>
                ) : <div key={idx}></div>
              ))}
            </div>
          </div>
        )}

        {/* Экран 3: PUSH SCREEN */}
        {screen === 'PUSH' && (
          <div className={`h-full bg-gradient-to-b ${user.bgGradient} p-6 flex flex-col justify-center items-center text-center`}>
            <button 
              onClick={() => setScreen('MAIN')}
              className="w-full velvet-pillow py-16 cursor-pointer mb-6"
            >
              <h1 className="text-5xl font-black text-white tracking-widest">PUSH</h1>
            </button>
            
            <div className="velvet-pillow px-8 py-3">
              <span className={`font-bold tracking-wider ${user.accentColor}`}>{user.name}</span>
            </div>
          </div>
        )}

        {/* Экран 4: MAIN MENU */}
        {screen === 'MAIN' && (
          <div className={`h-full bg-gradient-to-b ${user.bgGradient} p-6 flex flex-col justify-between`}>
            <div className="flex justify-between items-center gap-4">
              <button onClick={() => setScreen('PROFILE')} className="velvet-pillow px-4 py-2.5 flex items-center gap-2">
                <User className="w-4 h-4 text-amber-400" />
                <span className={`text-xs font-bold ${user.accentColor}`}>ПРОФИЛЬ</span>
              </button>
              <button onClick={() => setScreen('LOGIN')} className="velvet-pillow px-4 py-2.5 flex items-center gap-2">
                <LogOut className="w-4 h-4 text-red-400" />
                <span className={`text-xs font-bold ${user.accentColor}`}>ВЫХОД</span>
              </button>
            </div>

            <div className="velvet-pillow p-4 text-center">
              <h2 className={`text-xl font-black tracking-wider ${user.accentColor}`}>{user.name}</h2>
            </div>

            <div className="grid grid-cols-2 gap-4 my-auto">
              <button className="velvet-pillow p-6 h-32 flex justify-center items-center">
                <span className={`font-black text-center text-sm ${user.accentColor}`}>КТО ЛУЧШЕ<br/>ЗНАЕТ?</span>
              </button>
              <button className="velvet-pillow p-6 h-32 flex justify-center items-center">
                <span className={`font-black text-center text-sm ${user.accentColor}`}>СЛУЧАЙНОЕ<br/>ЗАДАНИЕ</span>
              </button>
              <button className="velvet-pillow p-6 h-32 flex justify-center items-center">
                <span className={`font-black text-center text-sm ${user.accentColor}`}>НАШИ<br/>ВОПРОСЫ ?</span>
              </button>
              <button className="velvet-pillow p-6 h-32 flex justify-center items-center">
                <span className={`font-black text-center text-sm ${user.accentColor}`}>УГАДАЙ<br/>МЕНЯ</span>
              </button>
            </div>
          </div>
        )}

        {/* Экран 5: PROFILE SCREEN */}
        {screen === 'PROFILE' && (
          <div className={`h-full bg-gradient-to-b ${user.bgGradient} p-6 flex flex-col justify-between`}>
            <div className="flex justify-between items-center gap-3">
              <div className="velvet-pillow flex-1 py-3 px-4 text-center">
                <span className={`font-black text-sm tracking-wider ${user.accentColor}`}>ВАШ ПРОФИЛЬ</span>
              </div>
              <div className="velvet-pillow p-3 rounded-full">
                <Settings className={`w-5 h-5 ${user.accentColor}`} />
              </div>
            </div>

            {/* Аватар в форме пончика */}
            <div className="relative w-44 h-44 mx-auto my-2 rounded-full velvet-pillow p-3 flex justify-center items-center">
              <img 
                src={user.avatar} 
                alt="Avatar" 
                className="w-full h-full rounded-full object-cover border-2 border-neutral-700" 
              />
            </div>

            <div className="velvet-pillow py-2 px-6 mx-auto text-center">
              <span className={`font-bold text-sm ${user.accentColor}`}>{user.name}</span>
            </div>

            <div className="grid grid-cols-2 gap-3">
              <div className="velvet-pillow p-3 flex justify-center items-center gap-2">
                <Zap className={`w-4 h-4 ${user.accentColor}`} />
                <span className={`text-xs font-bold ${user.accentColor}`}>ПОБЕД: {user.wins}</span>
              </div>
              <div className="velvet-pillow p-3 flex justify-center items-center gap-2">
                <Trophy className={`w-4 h-4 ${user.accentColor}`} />
                <span className={`text-xs font-bold ${user.accentColor}`}>РЕЙТИНГ: {user.rating}%</span>
              </div>
            </div>

            <div className="velvet-pillow p-3 flex justify-center items-center gap-2">
              <Heart className={`w-4 h-4 ${user.accentColor}`} />
              <span className={`text-xs font-bold ${user.accentColor}`}>СЫГРАНО ДУЭЛЕЙ: {user.duels}</span>
            </div>

            <div className="velvet-pillow p-4 flex justify-around items-center">
              <button onClick={() => setScreen('MAIN')} className="flex items-center gap-2 text-xs font-bold text-white">
                <RefreshCw className="w-4 h-4" />
                СЫГРАТЬ СНОВА
              </button>
              <div className="w-px h-4 bg-neutral-700"></div>
              <button onClick={() => setScreen('MAIN')} className="flex items-center gap-2 text-xs font-bold text-white">
                <Home className="w-4 h-4" />
                ГЛАВНОЕ МЕНЮ
              </button>
            </div>
          </div>
        )}

      </div>
    </div>
  );
}
